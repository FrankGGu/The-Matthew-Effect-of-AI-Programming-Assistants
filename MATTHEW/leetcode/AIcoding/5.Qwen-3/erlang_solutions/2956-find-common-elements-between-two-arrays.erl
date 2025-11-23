-module(solution).
-export([common_elements/2]).

common_elements(Arr1, Arr2) ->
    Set1 = sets:from_list(Arr1),
    Set2 = sets:from_list(Arr2),
    Sets = sets:intersection(Set1, Set2),
    sets:to_list(Sets).