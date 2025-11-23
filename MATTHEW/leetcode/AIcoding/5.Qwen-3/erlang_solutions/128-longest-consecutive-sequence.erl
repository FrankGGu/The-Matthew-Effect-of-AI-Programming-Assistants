-module(longest_consecutive_sequence).
-export([longest_consecutive_sequence/1]).

longest_consecutive_sequence([]) -> 0;
longest_consecutive_sequence(List) ->
    Set = sets:from_list(List),
    lists:max([traverse(Set, X) || X <- sets:to_list(Set)]).

traverse(_Set, _X) -> 0;
traverse(Set, X) ->
    case sets:is_element(X - 1, Set) of
        true -> 1 + traverse(Set, X - 1);
        false -> 1
    end.