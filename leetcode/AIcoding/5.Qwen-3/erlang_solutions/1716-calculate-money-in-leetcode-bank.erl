-module(money_in_bank).
-export([total_money/1]).

total_money(N) ->
    total_money(N, 0, 0).

total_money(0, _, Acc) ->
    Acc;
total_money(N, Week, Acc) ->
    Add = 5 * Week + 1,
    total_money(N - 1, Week + 1, Acc + Add).