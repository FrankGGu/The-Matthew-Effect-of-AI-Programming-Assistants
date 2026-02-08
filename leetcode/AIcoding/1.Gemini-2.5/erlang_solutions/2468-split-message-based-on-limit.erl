-module(solution).
-export([splitMessage/2]).

-spec num_digits(integer()) -> integer().
num_digits(N) when N < 10 -> 1;
num_digits(N) when N < 100 -> 2;
num_digits(N) when N < 1000 -> 3;
num_digits(N) when N < 10000 -> 4;
num_digits(N) when N < 100000 -> 5;
num_digits(N) when N < 1000000 -> 6;
num_digits(N) -> length(integer_to_list(N)). % Fallback for larger numbers, though N max 10^5 means 6 digits max for K

-spec sum_digits_length(integer()) -> integer().
sum_digits_length(K) ->
    sum_digits_length_acc(K, 1, 0, 0, 9).

-spec sum_digits_length_acc(integer(), integer(), integer(), integer(), integer()) -> integer().
sum_digits_length_acc(K, CurrentDigits, AccSum, PrevMax, BlockSize) ->
    NextMax = PrevMax + BlockSize,
    if
        K =< NextMax ->
            AccSum + (K - PrevMax) * CurrentDigits;
        true ->
            NewAccSum = AccSum + BlockSize * CurrentDigits,
            sum_digits_length_acc(K, CurrentDigits + 1, NewAccSum, NextMax, BlockSize * 10)
    end.

-spec splitMessage(string(), integer()) -> [string()].
splitMessage(Message, Limit) ->
    N = length(Message),

    % Minimum limit check: A part must contain at least 1 character of message content.
    % The smallest possible suffix is for "1/1" (i=1, k=1), which is "/1/1" (4 characters).
    % So, minimum part length is 1 (content) + 4 (suffix) = 5.
    % If Limit < 5, it's impossible.
    if Limit < 5 ->
        [];
    true ->
        % Iterate k (number of parts) from 1 upwards to find the minimum k
        % The maximum possible K can be N (if Limit is small, each part takes 1 char)
        % or up to around 2 * 10^5 (a safe upper bound for K given N <= 10^5)
        find_min_k(1, N, Limit, Message)
    end.

-spec find_min_k(integer(), integer(), integer(), string()) -> [string()].
find_min_k(K, N, Limit, Message) ->
    % A safe upper bound for K. Max N is 10^5. If K exceeds 2*N, it's likely impossible
    % or the calculation for K becomes too large.
    % Max K is around 10^5 (when N=10^5, Limit=5).
    if K > 200000 -> % Heuristic limit for K
        [];
    true ->
        NumDigitsK = num_digits(K),

        % Check if Limit is sufficient for the largest suffix (which is for part K)
        % For part K, the suffix length is 2 + num_digits(K) + num_digits(K).
        % Content length for part K must be at least 1.
        % So, Limit - (2 + num_digits(K) + num_digits(K)) >= 1
        % This implies Limit >= 3 + 2 * num_digits(K)
        MinPossibleLimitForK = 3 + 2 * NumDigitsK,
        if Limit < MinPossibleLimitForK ->
            % If the limit is too small for the last part, it's impossible for this K or any larger K.
            [];
        true ->
            SumDigitsI = sum_digits_length(K),

            % Calculate total message content characters that can be accommodated by K parts
            % TotalContent = Sum_{i=1 to K} (Limit - (2 + num_digits(i) + num_digits(K)))
            %              = K * (Limit - 2 - num_digits(K)) - Sum_{i=1 to K} num_digits(i)
            TotalContentAvailable = K * (Limit - 2 - NumDigitsK) - SumDigitsI,

            if TotalContentAvailable >= N ->
                % This K works, now construct the parts
                construct_parts(Message, K, Limit, 1, []);
            true ->
                % This K is too small, try next K
                find_min_k(K + 1, N, Limit, Message)
            end
        end
    end.

-spec construct_parts(string(), integer(), integer(), integer(), list(iolist())) -> [string()].
construct_parts(RemainingMessage, K, Limit, CurrentPartNum, AccParts) ->
    if CurrentPartNum > K ->
        % All parts constructed, flatten them and reverse to correct order
        lists:map(fun lists:flatten/1, lists:reverse(AccParts));
    true ->
        NumDigitsK = num_digits(K),
        NumDigitsCurrentPart = num_digits(CurrentPartNum),
        SuffixLen = 2 + NumDigitsCurrentPart + NumDigitsK, % e.g., "/1/1" -> 4, "/10/100" -> 7
        ContentLen = Limit - SuffixLen,

        % Split RemainingMessage to get the content for the current part
        % lists:splitat takes O(ContentLen) time. Total O(N) across all calls.
        {SubMessage, NewRemainingMessage} = lists:splitat(ContentLen, RemainingMessage),

        % Format the suffix string. io_lib:format returns a string (list of chars).
        % Total O(K * log(K)) across all calls.
        Suffix = io_lib:format("/~w/~w", [CurrentPartNum, K]),

        % Store part as an iolist. Flattening happens once at the end.
        PartIolist = [SubMessage, Suffix],

        construct_parts(NewRemainingMessage, K, Limit, CurrentPartNum + 1, [PartIolist | AccParts])
    end.