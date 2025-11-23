-module(solution).
-export([minCharacters/2]).

make_zeros_tuple(N) -> list_to_tuple(lists:duplicate(N, 0)).

update_freq_tuple(Char, FreqTuple) ->
    Idx = Char - $a + 1, % Tuple elements are 1-indexed
    setelement(Idx, FreqTuple, element(Idx, FreqTuple) + 1).

get_freq_tuple(S) ->
    lists:foldl(fun(Char, AccFreq) -> update_freq_tuple(Char, AccFreq) end, make_zeros_tuple(26), S).

get_prefix_sums_tuple(FreqTuple) ->
    get_prefix_sums_tuple_acc(FreqTuple, 1, 0, []).

get_prefix_sums_tuple_acc(_FreqTuple, 27, _CurrentSum, Acc) -> list_to_tuple(lists:reverse(Acc));
get_prefix_sums_tuple_acc(FreqTuple, Idx, CurrentSum, Acc) ->
    Count = element(Idx, FreqTuple),
    NewSum = CurrentSum + Count,
    get_prefix_sums_tuple_acc(FreqTuple, Idx + 1, NewSum, [NewSum|Acc]).

minCharacters(A_Str, B_Str) ->
    A_List = string:to_list(A_Str),
    B_List = string:to_list(B_Str),
    LenA = length(A_List),
    LenB = length(B_List),

    FreqA = get_freq_tuple(A_List),
    FreqB = get_freq_tuple(B_List),

    PrefixA = get_prefix_sums_tuple(FreqA),
    PrefixB = get_prefix_sums_tuple(FreqB),

    % Condition 1: Every character in 'a' is strictly less than every character in 'b'.
    % This means there exists a character 'x' (from 'a' to 'y') such that:
    % all characters in 'a' are <= 'x' AND all characters in 'b' are > 'x'.
    % Cost for a given 'x' (represented by 0-indexed K):
    %   (Count of chars in 'a' > 'x') + (Count of chars in 'b' <= 'x')
    %   = (LenA - PrefixA[K]) + PrefixB[K]
    Cond1Costs = lists:map(fun(K) ->
                                        % K is 0-indexed, tuple access is 1-indexed
                                        (LenA - element(K + 1, PrefixA)) + element(K + 1, PrefixB)
                                end, lists:seq(0, 24)), % K from 'a' (0) to 'y' (24)
    MinCond1 = lists:min(Cond1Costs),

    % Condition 2: Every character in 'b' is strictly less than every character in 'a'.
    % Symmetric to Condition 1.
    % Cost for a given 'x' (represented by 0-indexed K):
    %   (Count of chars in 'b' > 'x') + (Count of chars in 'a' <= 'x')
    %   = (LenB - PrefixB[K]) + PrefixA[K]
    Cond2Costs = lists:map(fun(K) ->
                                        (LenB - element(K + 1, PrefixB)) + element(K + 1, PrefixA)
                                end, lists:seq(0, 24)), % K from 'a' (0) to 'y' (24)
    MinCond2 = lists:min(Cond2Costs),

    % Condition 3: Both 'a' and 'b' consist of only one distinct character.
    % Iterate through all possible characters 'c' (from 'a' to 'z').
    % Cost for a given 'c' (represented by 0-indexed K):
    %   (Count of chars in 'a' not equal to 'c') + (Count of chars in 'b' not equal to 'c')
    %   = (LenA - FreqA[K]) + (LenB - FreqB[K])
    Cond3Costs = lists:map(fun(K) ->
                                        (LenA - element(K + 1, FreqA)) + (LenB - element(K + 1, FreqB))
                                end, lists:seq(0, 25)), % K from 'a' (0) to 'z' (25)
    MinCond3 = lists:min(Cond3Costs),

    lists:min([MinCond1, MinCond2, MinCond3]).