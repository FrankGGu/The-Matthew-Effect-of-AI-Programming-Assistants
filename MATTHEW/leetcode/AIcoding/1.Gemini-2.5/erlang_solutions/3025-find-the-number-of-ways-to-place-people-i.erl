-module(solution).
-export([number_of_ways/1]).

-spec number_of_ways(Points :: [[integer()]]) -> integer().
number_of_ways(Points) ->
    Arr = array:from_list(Points),
    N = array:size(Arr),
    count_pairs_array(Arr, N, 0, 0).

count_pairs_array(Arr, N, I, Acc) when I < N ->
    PersonI = array:get(I, Arr),
    count_pairs_array_inner(Arr, N, I, 0, PersonI, Acc);
count_pairs_array(_Arr, _N, _I, Acc) ->
    Acc.

count_pairs_array_inner(Arr, N, I, J, PersonI, Acc) when J < N ->
    NewAcc =
        if
            I == J -> Acc;
            true ->
                PersonJ = array:get(J, Arr),
                [Xi, Yi] = PersonI,
                [Xj, Yj] = PersonJ,
                if
                    Xi >= Xj andalso Yi <= Yj -> Acc + 1;
                    true -> Acc
                end
        end,
    count_pairs_array_inner(Arr, N, I, J + 1, PersonI, NewAcc);
count_pairs_array_inner(Arr, N, I, _J, _PersonI, Acc) ->
    count_pairs_array(Arr, N, I + 1, Acc).