-module(solution).
-export([goodDaysToRobBank/2]).

goodDaysTorobBank(Security, time) ->
    N = length(Security),
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    LeftAcc = lists:foldl(fun(I, Acc) ->
        if
            I == 0 -> [0 | Acc];
            true -> [if Security:I >= Security:(I-1) -> Acc--1 + 1; true -> 0 end | Acc]
        end
    end, [], lists:reverse(lists:seq(0, N-1))),
    RightAcc = lists:foldl(fun(I, Acc) ->
        if
            I == N-1 -> [0 | Acc];
            true -> [if Security:I >= Security:(I+1) -> Acc--1 + 1; true -> 0 end | Acc]
        end
    end, [], lists:seq(0, N-1)),
    lists:foldl(fun(I, Acc) ->
        if
            LeftAcc:I >= time andalso RightAcc:I >= time -> [I | Acc];
            true -> Acc
        end
    end, [], lists:seq(0, N-1)).

goodDaysToRobBank(Security, Time) ->
    N = length(Security),
    Left = lists:seq(0, N-1),
    Right = lists:seq(0, N-1),
    LeftAcc = lists:foldl(fun(I, Acc) ->
        if
            I == 0 -> [0 | Acc];
            true -> [if lists:nth(I+1, Security) <= lists:nth(I, Security) -> lists:nth(I, Acc) + 1; true -> 0 end | Acc]
        end
    end, [], lists:reverse(lists:seq(0, N-1))),
    RightAcc = lists:foldl(fun(I, Acc) ->
        if
            I == N-1 -> [0 | Acc];
            true -> [if lists:nth(I+1, Security) <= lists:nth(I, Security) -> lists:nth(I, Acc) + 1; true -> 0 end | Acc]
        end
    end, [], lists:seq(0, N-1)),
    lists:foldl(fun(I, Acc) ->
        if
            lists:nth(I+1, LeftAcc) >= Time andalso lists:nth(I+1, RightAcc) >= Time -> [I | Acc];
            true -> Acc
        end
    end, [], lists:seq(0, N-1)).