-module(solution).
-export([shortest_impossible_sequence/1]).

shortest_impossible_sequence(Rolls) ->
    RollsSet = maps:from_list(Rolls),
    MinLength = 1,
    MaxLength = 6,
    case find_sequence(MinLength, MaxLength, RollsSet) of
        none -> -1;
        {ok, Sequence} -> Sequence
    end.

find_sequence(Length, MaxLength, RollsSet) when Length > MaxLength ->
    none;
find_sequence(Length, MaxLength, RollsSet) ->
    Sequence = lists:seq(1, Length),
    case lists:all(fun(X) -> maps:is_key(X, RollsSet) end, Sequence) of
        true -> find_sequence(Length + 1, MaxLength, RollsSet);
        false -> {ok, Sequence}
    end.