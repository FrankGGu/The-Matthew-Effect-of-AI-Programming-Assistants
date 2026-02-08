-module(solution).
-export([rearrange_spaces/1]).

rearrange_spaces(Str) ->
    Words = string:tokens(Str, " "),
    CountSpaces = lists:foldl(fun(Char, Acc) -> if Char =:= $\s -> Acc + 1; true -> Acc end end, 0, Str),
    NonEmptyWords = lists:filter(fun(W) -> W =/= "" end, Words),
    CountWords = length(NonEmptyWords),
    CaseCount = if CountWords > 1 -> CountSpaces div (CountWords - 1); true -> 0 end,
    Remainder = if CountWords > 1 -> CountSpaces rem (CountWords - 1); true -> CountSpaces end,
    Spaces = string:duplicate(" ", CaseCount),
    Result = lists:foldl(fun(W, Acc) -> Acc ++ W ++ Spaces end, lists:hd(NonEmptyWords), tl(NonEmptyWords)),
    Result ++ string:duplicate(" ", Remainder).