-module(solution).
-export([first_unique_char/1]).

first_unique_char(S) ->
    FreqMap = count_frequencies(S),
    find_first_unique(S, FreqMap, 0).

count_frequencies(S) ->
    lists:foldl(fun(C, AccMap) -> maps:update_with(C, fun(V) -> V + 1 end, 1, AccMap) end, #{}, S).

find_first_unique([], _FreqMap, _Index) ->
    -1;
find_first_unique([H|T], FreqMap, Index) ->
    case maps:get(H, FreqMap) of
        1 ->
            Index;
        _ ->
            find_first_unique(T, FreqMap, Index + 1)
    end.