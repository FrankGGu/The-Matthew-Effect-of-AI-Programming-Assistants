-spec sum_four_divisors(Nums :: [integer()]) -> integer().
sum_four_divisors(Nums) ->
    lists:sum([sum_divisors(Num) || Num <- Nums]).

sum_divisors(Num) ->
    case get_divisors(Num) of
        [1, D, Num div D, Num] when D =/= Num div D ->
            1 + D + (Num div D) + Num;
        _ ->
            0
    end.

get_divisors(Num) ->
    Divisors = [1],
    Max = trunc(math:sqrt(Num)),
    get_divisors(Num, 2, Max, Divisors).

get_divisors(Num, D, Max, Divisors) when D =< Max ->
    if
        Num rem D =:= 0 ->
            NewDivisors = [D | Divisors],
            if
                D =/= Num div D ->
                    get_divisors(Num, D + 1, Max, [Num div D | NewDivisors]);
                true ->
                    get_divisors(Num, D + 1, Max, NewDivisors)
            end;
        true ->
            get_divisors(Num, D + 1, Max, Divisors)
    end;
get_divisors(Num, _D, _Max, Divisors) ->
    lists:sort([Num | Divisors]).