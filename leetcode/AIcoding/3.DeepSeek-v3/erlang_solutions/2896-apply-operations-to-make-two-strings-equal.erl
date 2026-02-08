-spec min_operations(s1 :: unicode:unicode_binary(), s2 :: unicode:unicode_binary(), x :: integer()) -> integer().
min_operations(S1, S2, X) ->
    S1List = binary_to_list(S1),
    S2List = binary_to_list(S2),
    Diff = lists:zipwith(fun(A, B) -> A =/= B end, S1List, S2List),
    Indices = [I || {I, true} <- lists:zip(lists:seq(0, length(Diff) - 1), Diff)],
    case length(Indices) rem 2 of
        1 -> -1;
        0 -> 
            case Indices of
                [] -> 0;
                _ ->
                    Pairs = lists:zip(lists:sublist(Indices, 1, length(Indices) - 1),
                    Costs = lists:map(fun({I, J}) -> min(X, J - I) end, Pairs),
                    lists:sum(Costs)
            end
    end.