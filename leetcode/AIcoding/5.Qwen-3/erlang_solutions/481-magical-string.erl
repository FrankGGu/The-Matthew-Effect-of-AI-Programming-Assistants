-module(magical_string).
-export([magical_string/1]).

magical_string(N) ->
    magical_string(N, 2, [1, 3], 2).

magical_string(0, _, _, _) -> [];
magical_string(1, _, _, _) -> [1];
magical_string(2, _, _, _) -> [1, 3];
magical_string(N, Index, List, Next) when N > length(List) ->
    case lists:nth(Index, List) of
        1 ->
            NewList = List ++ [Next],
            magical_string(N, Index + 1, NewList, Next + 1);
        2 ->
            NewList = List ++ [Next, Next],
            magical_string(N, Index + 1, NewList, Next + 1)
    end;
magical_string(N, _, List, _) ->
    lists:sublist(List, N).