-module(solution).
-export([min_valid_strings/2]).

min_valid_strings(Starts, Target) ->
    Sets = lists:map(fun(Str) -> sets:from_list(Str) end, Starts),
    min_valid_strings(Sets, Target, 0).

min_valid_strings(_, [], _) ->
    0;
min_valid_strings(Sets, [C | Rest], Count) ->
    Candidates = lists:filter(fun(Set) -> sets:is_element(C, Set) end, Sets),
    if
        Candidates == [] -> -1;
        true ->
            NewCount = Count + 1,
            NextTarget = lists:dropwhile(fun(X) -> X /= C end, Rest),
            case min_valid_strings(Sets, NextTarget, NewCount) of
                -1 -> -1;
                N -> N
            end
    end.