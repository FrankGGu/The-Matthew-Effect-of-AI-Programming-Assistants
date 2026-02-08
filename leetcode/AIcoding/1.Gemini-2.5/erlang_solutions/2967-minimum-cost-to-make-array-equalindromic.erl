-module(solution).
-export([minimumCost/1]).

build_palindrome(FirstHalfStr, IsOddLength) ->
    RevFirstHalf = lists:reverse(FirstHalfStr),
    NumStr = if IsOddLength -> FirstHalfStr ++ tl(RevFirstHalf);
               true -> FirstHalfStr ++ RevFirstHalf
             end,
    list_to_integer(NumStr).

generate_all_palindromes(MaxVal) ->
    Pals = sets:new(),
    %% Iterate through possible lengths of the first half.
    %% For numbers up to 10^9, the maximum number of digits is 10.
    %% A 10-digit palindrome (e.g., 1234554321) has a first half of 5 digits (12345).
    %% A 9-digit palindrome (e.g., 123454321) has a first half of 5 digits (12345).
    %% So, L_half (length of the first half) ranges from 1 to 5.
    lists:foldl(fun(L_half, AccPals) ->
        MinFirstHalf = if L_half == 1 then 1 else erlang:trunc(erlang:pow(10, L_half - 1)) end,
        MaxFirstHalf = erlang:trunc(erlang:pow(10, L_half) - 1),
        lists:foldl(fun(FirstHalfNum, CurrentPals) ->
            FirstHalfStr = integer_to_list(FirstHalfNum),

            P_odd = build_palindrome(FirstHalfStr, true),
            P_even = build_palindrome(FirstHalfStr, false),

            NewPals1 = if P_odd =< MaxVal -> sets:add_element(P_odd, CurrentPals) else CurrentPals end,
            NewPals2 = if P_even =< MaxVal -> sets:add_element(P_even, NewPals1) else NewPals1 end,
            NewPals2
        end, AccPals, lists:seq(MinFirstHalf, MaxFirstHalf))
    end, Pals, lists:seq(1, 5)).

calculate_cost(Nums, P) ->
    lists:foldl(fun(N, Acc) -> Acc + erlang:abs(N - P) end, 0, Nums).

get_closest_palindrome_idx(Pals, Target) ->
    Len = length(Pals),
    get_closest_palindrome_idx(Pals, Target, 1, Len, 1). % Start BestIdx at 1 (Erlang lists are 1-indexed)

get_closest_palindrome_idx(_Pals, _Target, Low, High, BestIdx) when Low > High ->
    BestIdx;
get_closest_palindrome_idx(Pals, Target, Low, High, BestIdx) ->
    Mid = Low + (High - Low) div 2,
    MidVal = lists:nth(Mid, Pals),
    BestVal = lists:nth(BestIdx, Pals),
    NewBestIdx = if erlang:abs(MidVal - Target) < erlang:abs(BestVal - Target) -> Mid;
                   true -> BestIdx
                 end,
    if MidVal < Target ->
        get_closest_palindrome_idx(Pals, Target, Mid + 1, High, NewBestIdx);
    else % MidVal >= Target
        get_closest_palindrome_idx(Pals, Target, Low, Mid - 1, NewBestIdx)
    end.

minimumCost(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    %% For sum(|x_i - X|) the optimal X is the median.
    %% For even N, we can pick either of the two middle elements.
    %% (N+1) div 2 gives the lower median for even N, and the median for odd N.
    Median = lists:nth((N + 1) div 2, SortedNums), 

    MaxNumVal = 1000000000, % Maximum value of nums[i]
    AllPalindromesSet = generate_all_palindromes(MaxNumVal),
    AllPalindromes = lists:sort(sets:to_list(AllPalindromesSet)),

    ClosestIdx = get_closest_palindrome_idx(AllPalindromes, Median),

    %% Select a window of palindromes around the closest one.
    %% K = 1000 is chosen to balance between covering enough candidates and performance.
    %% For N=10^5, K*N = 1000 * 10^5 = 10^8 operations, which is acceptable.
    K = 1000, 
    StartIdx = max(1, ClosestIdx - K),
    EndIdx = min(length(AllPalindromes), ClosestIdx + K),

    CandidatePalindromes = lists:sublist(AllPalindromes, StartIdx, EndIdx - StartIdx + 1),

    MinCost = lists:foldl(fun(P, AccMinCost) ->
        CurrentCost = calculate_cost(SortedNums, P),
        min(AccMinCost, CurrentCost)
    end, infinity, CandidatePalindromes),
    MinCost.