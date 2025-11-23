-module(verbal_arithmetic_puzzle).
-export([is_solvable/1]).

is_solvable(Puzzle) ->
    [Left, Right] = string:split(Puzzle, " = "),
    LeftTerms = string:split(Left, " + "),
    AllTerms = LeftTerms ++ [Right],
    Letters = lists:usort(lists:flatten([string:to_list(Term) || Term <- AllTerms])),
    MaxLength = lists:max([length(Term) || Term <- AllTerms]),
    if
        length(Letters) > 10 -> false;
        true ->
            Assignments = assign_letters(Letters, []),
            solve(AllTerms, Assignments, 0)
    end.

assign_letters([], Acc) -> Acc;
assign_letters([L | Rest], Acc) ->
    assign_letters(Rest, [L | Acc]).

solve(_, [], _) -> false;
solve(AllTerms, Assignments, Index) ->
    case get_next_assignment(Assignments, Index) of
        {Value, NewAssignments} ->
            case check_assignment(AllTerms, Assignments, Value) of
                true -> true;
                false -> solve(AllTerms, NewAssignments, Index + 1)
            end;
        false -> false
    end.

get_next_assignment([], _) -> false;
get_next_assignment([L | Rest], Index) ->
    case lists:keyfind(L, 1, Assignments) of
        false ->
            {Index, [{L, Index} | Rest]};
        _ -> get_next_assignment(Rest, Index)
    end.

check_assignment(AllTerms, Assignments, Value) ->
    SumLeft = lists:sum([term_value(Term, Assignments) || Term <- LeftTerms]),
    RightValue = term_value(Right, Assignments),
    SumLeft == RightValue.

term_value(Term, Assignments) ->
    lists:foldl(fun(Char, Acc) ->
                    Digit = lists:foldl(fun({C, D}, Acc2) ->
                                            if C == Char -> D;
                                               true -> Acc2
                                            end end, -1, Assignments),
                    Acc * 10 + Digit
                end, 0, string:to_list(Term)).