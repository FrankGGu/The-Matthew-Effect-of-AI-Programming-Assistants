-module(letter_tile_possibilities).
-export([num_tile_possibilities/1]).

num_tile_possibilities(Tiles) ->
    Count = count_letters(Tiles),
    calculate(Count).

count_letters([]) -> [];
count_letters([H|T]) ->
    [H | count_letters(T)].

calculate(Count) ->
    lists:foldl(fun({Char, N}, Acc) ->
        Acc * (math:pow(2, N) - 1)
    end, 1, Count).

count_letters(List) ->
    count_letters(List, #{}).

count_letters([], Acc) ->
    maps:to_list(Acc);
count_letters([H|T], Acc) ->
    NewAcc = case maps:is_key(H, Acc) of
        true -> maps:update(H, maps:get(H, Acc) + 1, Acc);
        false -> maps:put(H, 1, Acc)
    end,
    count_letters(T, NewAcc).