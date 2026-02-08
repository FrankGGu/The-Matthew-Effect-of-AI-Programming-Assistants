-spec circular_permutation(N :: integer(), Start :: integer()) -> [integer()].
circular_permutation(N, Start) ->
    Gray = lists:map(fun(X) -> X bxor (X bsr 1) end, lists:seq(0, (1 bsl N) - 1)),
    Index = index_of(Start, Gray, 0),
    rotate_list(Gray, Index).

index_of(Val, [Val | _], Index) -> Index;
index_of(Val, [_ | T], Index) -> index_of(Val, T, Index + 1).

rotate_list(List, 0) -> List;
rotate_list([H | T], N) -> rotate_list(T ++ [H], N - 1).