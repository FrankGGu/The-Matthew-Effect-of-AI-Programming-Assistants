-module(solution).
-export([relative_sort/2]).

relative_sort(A, B) ->
    Map = maps:from_list([{Val, Index} || {Index, Val} <- lists:zip(lists:seq(0, length(B)-1), B)]),
    SortFun = fun(X, Y) ->
        case maps:find(X, Map) of
            {ok, XIdx} ->
                case maps:find(Y, Map) of
                    {ok, YIdx} -> XIdx - YIdx;
                    _ -> 1
                end;
            _ ->
                case maps:find(Y, Map) of
                    {ok, YIdx} -> -1;
                    _ -> X - Y
                end
        end
    end,
    lists:sort(SortFun, A).