-module(longest_consecutive).
-export([longest_consecutive/1]).

longest_consecutive([]) -> 0;
longest_consecutive(Nums) ->
    Set = sets:from_list(Nums),
    lists:max([count_consecutive(Set, N) || N <- sets:to_list(Set)]).

count_consecutive(Set, N) ->
    case sets:is_element(N - 1, Set) of
        true -> count_consecutive(Set, N - 1) + 1;
        false -> 1
    end.