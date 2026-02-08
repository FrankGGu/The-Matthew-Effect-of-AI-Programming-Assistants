-module(longest_square_streak_in_array).
-export([longest_square_streak/1]).

longest_square_streak(Nums) ->
    Sorted = lists:sort(Nums),
    Map = maps:from_list([{N, true} || N <- Sorted]),
    MaxLength = 1,
    lists:foldl(fun(N, Acc) -> find_length(N, Map, 1, Acc) end, MaxLength, Sorted).

find_length(N, Map, Current, Max) ->
    case maps:is_key(N*N, Map) of
        true ->
            NewCurrent = Current + 1,
            if NewCurrent > Max -> NewCurrent;
               true -> Max
            end;
        false ->
            Max
    end.