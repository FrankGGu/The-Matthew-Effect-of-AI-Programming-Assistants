-module(solution).
-export([numSpecialEquivGroups/1]).

numSpecialEquivGroups(A) ->
    UniqueRepresentations = sets:new(),
    lists:foldl(fun(String, AccSet) ->
                        Rep = get_canonical_representation(String),
                        sets:add_element(Rep, AccSet)
                end, UniqueRepresentations, A),
    sets:size(UniqueRepresentations).

get_canonical_representation(String) ->
    get_canonical_representation_recursively(String, 0, [], []).

get_canonical_representation_recursively([], _Index, EvenChars, OddChars) ->
    {lists:sort(EvenChars), lists:sort(OddChars)};
get_canonical_representation_recursively([H|T], Index, EvenChars, OddChars) ->
    if
        Index rem 2 == 0 ->
            get_canonical_representation_recursively(T, Index + 1, [H|EvenChars], OddChars);
        true ->
            get_canonical_representation_recursively(T, Index + 1, EvenChars, [H|OddChars])
    end.