-module(solution).
-export([maximum_removals/3]).

maximum_removals(Source, Target, MaxRemovals) ->
    binary_to_list(maximum_removals_helper(list_to_binary(Source), list_to_binary(Target), MaxRemovals, 0)).

maximum_removals_helper(Source, Target, MaxRemovals, Low) when Low =< MaxRemovals ->
    case can_form_from(Source, Target, Low) of
        true -> maximum_removals_helper(Source, Target, MaxRemovals, Low + 1);
        false -> Low - 1
    end.

can_form_from(Source, Target, Removals) ->
    SourceList = binary_to_list(Source),
    TargetList = binary_to_list(Target),
    ModifiedSource = remove_characters(SourceList, Removals),
    can_form(ModifiedSource, TargetList).

remove_characters(Source, 0) -> Source;
remove_characters(Source, Removals) ->
    lists:filter(fun(X) -> not lists:member(X, Source) end, lists:seq(97, 122)).

can_form(Source, Target) ->
    lists:all(fun(X) -> lists:member(X, Source) end, Target).