-module(solution).
-export([minimumSubstringsInPartition/1]).

is_valid(S) ->
    Freqs = count_frequencies(S),
    check_frequencies(Freqs).

count_frequencies(S) ->
    InitialFreqs = array:new([{size, 26}, {fixed, true}, {default, 0}]),
    lists:foldl(fun(Char, AccFreqs) ->
        Idx = Char - $a,
        array:set(Idx, array:get(Idx, AccFreqs) + 1, AccFreqs)
    end, InitialFreqs, S).

check_frequencies(FreqsArray) ->
    check_frequencies_loop(0, 25, FreqsArray, -1).

check_frequencies_loop(Idx, MaxIdx, FreqsArray, CurrentFirstFreq) when Idx =< MaxIdx ->
    Count = array:get(Idx, FreqsArray),
    if
        Count == 0 ->
            check_frequencies_loop(Idx + 1, MaxIdx, FreqsArray, CurrentFirstFreq);
        CurrentFirstFreq == -1 -> % First non-zero frequency found
            check_frequencies_loop(Idx + 1, MaxIdx, FreqsArray, Count);
        Count == CurrentFirstFreq -> % Subsequent non-zero frequency matches
            check_frequencies_loop(Idx + 1, MaxIdx, FreqsArray, CurrentFirstFreq);
        true -> % Mismatch found
            false
    end;
check_frequencies_loop(_Idx, _MaxIdx, _FreqsArray, _CurrentFirstFreq) ->
    true. % All frequencies checked and are consistent or no characters found (empty string case handled by DP base case)

minimumSubstringsInPartition(S) ->
    N = length(S),
    % dp[i] will store the minimum partitions for the prefix S[0...i-1]
    % Initialize dp array with N+1 (effectively infinity)
    DP = array:new([{size, N + 1}, {fixed, true}, {default, N + 1}]),
    % Base case: dp[0] = 0 (empty prefix requires 0 partitions)
    DP1 = array:set(0, 0, DP),

    % Iterate i from 1 to N
    FinalDP = lists:foldl(fun(I, CurrentDP) ->
        % Iterate j from 0 to i-1
        lists:foldl(fun(J, InnerDP) ->
            SubString = lists:sublist(S, J + 1, I - J), % Erlang sublist is 1-indexed, length
            if
                is_valid(SubString) ->
                    PrevDPJ = array:get(J, InnerDP),
                    CurrentMinForI = array:get(I, InnerDP),
                    array:set(I, min(CurrentMinForI, PrevDPJ + 1), InnerDP);
                true ->
                    InnerDP
            end
        end, CurrentDP, lists:seq(0, I - 1))
    end, DP1, lists:seq(1, N)),

    array:get(N, FinalDP).