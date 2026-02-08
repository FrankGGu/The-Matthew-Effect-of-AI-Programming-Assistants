-module(solution).
-export([can_assign/3]).

can_assign(N, Constraints, Assignments) ->
    case check_constraints(Constraints, Assignments) of
        true -> true;
        false -> false
    end.

check_constraints([], _Assignments) -> true;
check_constraints([{A, B} | Rest], Assignments) ->
    case {lists:member(A, Assignments), lists:member(B, Assignments)} of
        {true, true} -> false;
        _ -> check_constraints(Rest, Assignments)
    end.