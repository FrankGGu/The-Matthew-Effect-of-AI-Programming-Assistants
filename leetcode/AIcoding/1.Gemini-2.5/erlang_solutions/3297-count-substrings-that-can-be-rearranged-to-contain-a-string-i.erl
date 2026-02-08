-module(solution).
-export([countSubstrings/2]).

countSubstrings(S, Target) ->
    TargetFreq = char_freq(Target),
    N = length(S),
    count_substrings_loop(S, TargetFreq, N, 0, 0).

count_substrings_loop(S, TargetFreq, N, I, TotalCount) when I < N ->
    CurrentSubstrFreq = lists:duplicate(26, 0),
    CountForI = inner_loop(S, TargetFreq, N, I, I, CurrentSubstrFreq, 0),
    count_substrings_loop(S, TargetFreq, N, I + 1, TotalCount + CountForI);
count_substrings_loop(_S, _TargetFreq, _N, _I, TotalCount) ->
    TotalCount.

inner_loop(S, TargetFreq, N, I, J, CurrentSubstrFreq, CurrentCount) when J < N ->
    Char = lists:nth(J + 1, S),
    Index = Char - $a,
    NewSubstrFreq = lists:replace_nth(Index + 1, lists:nth(Index + 1, CurrentSubstrFreq) + 1, CurrentSubstrFreq),
    NewCurrentCount = if can_rearrange(NewSubstrFreq, TargetFreq) -> CurrentCount + 1; true -> CurrentCount end,
    inner_loop(S, TargetFreq, N, I, J + 1, NewSubstrFreq, NewCurrentCount);
inner_loop(_S, _TargetFreq, _N, _I, _J, _CurrentSubstrFreq, CurrentCount) ->
    CurrentCount.

char_freq(S) ->
    lists:foldl(
        fun(Char, FreqList) ->
            Index = Char - $a,
            lists:replace_nth(Index + 1, lists:nth(Index + 1, FreqList) + 1, FreqList)
        end,
        lists:duplicate(26, 0),
        S
    ).

can_rearrange(SubstrFreq, TargetFreq) ->
    lists:all(
        fun({SubCount, TargetCount}) ->
            SubCount >= TargetCount
        end,
        lists:zip(SubstrFreq, TargetFreq)
    ).