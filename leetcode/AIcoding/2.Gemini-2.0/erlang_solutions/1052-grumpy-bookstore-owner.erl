-module(grumpy_bookstore_owner).
-export([maxSatisfied/3]).

maxSatisfied(Customers, Grumpy, X) ->
    N = length(Customers),
    {InitialSatisfied, GrumpySatisfied} = lists:foldl(
        fun(
            {Cust, 0}, {IS, GS}) -> {IS + Cust, GS};
            {Cust, 1}, {IS, GS}) -> {IS, GS + Cust}
        end,
        {0, 0},
        lists:zip(Customers, Grumpy)
    ),

    maxSatisfiedHelper(Customers, Grumpy, X, 0, N, 0, 0, InitialSatisfied, GrumpySatisfied).

maxSatisfiedHelper(_Customers, _Grumpy, _X, I, N, _CurrentSum, MaxSum, _InitialSatisfied, _GrumpySatisfied) when I > N - _X ->
    MaxSum;
maxSatisfiedHelper(Customers, Grumpy, X, I, N, CurrentSum, MaxSum, InitialSatisfied, GrumpySatisfied) ->
    NewSum =
        case I > 0 of
            true ->
                case lists:nth(I, Grumpy) of
                    1 -> CurrentSum - lists:nth(I, Customers);
                    _ -> CurrentSum
                end;
            false -> CurrentSum
        end,
    NewSum2 =
        case I + X - 1 < N of
            true ->
                case lists:nth(I + X, Grumpy) of
                    1 -> NewSum + lists:nth(I + X, Customers);
                    _ -> NewSum
                end;
            false -> NewSum
        end,

    NewMaxSum = max(MaxSum, NewSum2),

    maxSatisfiedHelper(Customers, Grumpy, X, I + 1, N, NewSum2, NewMaxSum, InitialSatisfied, GrumpySatisfied).