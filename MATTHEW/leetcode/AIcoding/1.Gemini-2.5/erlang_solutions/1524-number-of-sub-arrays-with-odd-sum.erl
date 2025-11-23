-module(solution).
-export([num_subarrays_with_odd_sum/1]).

num_subarrays_with_odd_sum(Arr) ->
    MOD = 1000000007,
    {_, _, _, TotalOddSubarrays} = lists:foldl(
        fun(N, {CurrentSumParity, EvenCount, OddCount, Acc}) ->
            NewCurrentSumParity = (CurrentSumParity + (N rem 2)) rem 2,
            if
                NewCurrentSumParity == 1 ->
                    NewAcc = (Acc + EvenCount) rem MOD,
                    NewOddCount = OddCount + 1,
                    {NewCurrentSumParity, EvenCount, NewOddCount, NewAcc};
                NewCurrentSumParity == 0 ->
                    NewAcc = (Acc + OddCount) rem MOD,
                    NewEvenCount = EvenCount + 1,
                    {NewCurrentSumParity, NewEvenCount, OddCount, NewAcc}
            end
        end,
        {0, 1, 0, 0},
        Arr
    ),
    TotalOddSubarrays.