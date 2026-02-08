-module(solution).
-export([odd_even_transactions/1]).

odd_even_transactions(Transactions) ->
    odd_even_transactions(Transactions, 0, 0).

odd_even_transactions([], OddSum, EvenSum) ->
    [OddSum, EvenSum];
odd_even_transactions([H|T], OddSum, EvenSum) ->
    case H rem 2 of
        0 ->
            odd_even_transactions(T, OddSum, EvenSum + H);
        _ ->
            odd_even_transactions(T, OddSum + H, EvenSum)
    end.