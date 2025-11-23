-module(sievc).
-export([smallestEqualValue/1]).

smallestEqualValue(Numbers) ->
    smallestEqualValue(Numbers, 0, -1).

smallestEqualValue([], _, Result) ->
    Result;
smallestEqualValue([N | T], Index, Result) ->
    case N == Index of
        true ->
            if
                Result == -1 -> smallestEqualValue(T, Index + 1, Index);
                true -> smallestEqualValue(T, Index + 1, min(Result, Index))
            end;
        false ->
            smallestEqualValue(T, Index + 1, Result)
    end.