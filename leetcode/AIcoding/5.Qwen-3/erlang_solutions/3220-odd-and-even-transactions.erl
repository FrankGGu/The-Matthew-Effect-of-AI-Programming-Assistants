-module(odd_and_even_transactions).
-export([oddEven/1]).

oddEven(Transactions) ->
    {Odd, Even} = lists:foldl(fun(T, {O, E}) ->
        case T rem 2 of
            0 -> {O, E + 1};
            _ -> {O + 1, E}
        end
    end, {0, 0}, Transactions),
    [Odd, Even].