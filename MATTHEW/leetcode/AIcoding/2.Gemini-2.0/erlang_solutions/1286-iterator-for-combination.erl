-module(combination_iterator).
-export([new/2, has_next/1, next/1]).

-record(state, {
    characters :: string(),
    combination_length :: integer(),
    current_combination :: string(),
    combinations :: list(string())
}).

new(Characters, CombinationLength) ->
    Combinations = generate_combinations(Characters, CombinationLength),
    #state{
        characters = Characters,
        combination_length = CombinationLength,
        current_combination = "",
        combinations = Combinations
    }.

has_next(#state{combinations = []}) ->
    false;
has_next(#state{combinations = _}) ->
    true.

next(#state{combinations = [H|T]} = State) ->
    {H, State#state{combinations = T}}.

generate_combinations(Characters, CombinationLength) ->
    generate_combinations_helper(Characters, CombinationLength, []).

generate_combinations_helper(_, 0, Acc) ->
    [lists:reverse(Acc)];
generate_combinations_helper([], _, _) ->
    [];
generate_combinations_helper([H|T], Length, Acc) ->
    generate_combinations_helper(T, Length - 1, [H|Acc]) ++ generate_combinations_helper(T, Length, Acc).