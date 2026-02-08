-module(guess_number_higher_or_lower_ii).
-export([get_money/1]).

get_money(N) ->
    Money = array:new(N + 1, {default, 0}),
    get_money(N, Money).

get_money(1, _Money) ->
    0;
get_money(N, Money) ->
    get_money(N, 1, N, Money).

get_money(N, Start, End, Money) when Start > End ->
    0;
get_money(N, Start, End, Money) ->
    case array:get(Start, End, Money) of
        {ok, Val} ->
            Val;
        error ->
            MinCost = lists:min([
                Start + get_money(N, Start + 1, End, Money),
                End + get_money(N, Start, End - 1, Money),
                lists:foldl(fun I -> fun(I, Acc) -> min(Acc, I + get_money(N, Start, I - 1, Money) + get_money(N, I + 1, End, Money)) end end, infinity, lists:seq(Start + 1, End - 1))
            ]),
            array:set(Start, End, MinCost, Money),
            MinCost
    end.