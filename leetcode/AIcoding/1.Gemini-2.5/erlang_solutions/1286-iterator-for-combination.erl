-module(combination_iterator).

-export([new/2, next/1, hasNext/1]).

-record(iterator_state, {
    combinations :: [binary()],
    current_index :: integer()
}).

new(Characters, CombinationLength) ->
    CharList = string:to_list(Characters),
    AllCombinationsCharLists = generate_combinations(CharList, CombinationLength),
    SortedCombinationsCharLists = lists:sort(AllCombinationsCharLists),
    CombinationsAsBinaries = [list_to_binary(C) || C <- SortedCombinationsCharLists],
    #iterator_state{
        combinations = CombinationsAsBinaries,
        current_index = 0
    }.

next(State = #iterator_state{combinations = CombiList, current_index = Index}) ->
    CurrentCombination = lists:nth(Index + 1, CombiList),
    {CurrentCombination, State#iterator_state{current_index = Index + 1}}.

hasNext(#iterator_state{combinations = CombiList, current_index = Index}) ->
    Index < length(CombiList).

generate_combinations(_Chars, 0) ->
    [[]];
generate_combinations(Chars, K) when K > length(Chars) ->
    [];
generate_combinations([], _K) ->
    [];
generate_combinations([H|T], K) ->
    WithH = [ [H|C] || C <- generate_combinations(T, K-1) ],
    WithoutH = generate_combinations(T, K),
    WithH ++ WithoutH.