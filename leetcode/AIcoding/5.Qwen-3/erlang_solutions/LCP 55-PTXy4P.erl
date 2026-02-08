-module(fruit_collector).
-export([collect_fruits/1]).

collect_fruits(Fruits) ->
    collect_fruits(Fruits, 0, 0).

collect_fruits([], _, Acc) ->
    Acc;
collect_fruits([H | T], Index, Acc) ->
    case Index rem 2 of
        0 -> collect_fruits(T, Index + 1, Acc + H);
        _ -> collect_fruits(T, Index + 1, Acc)
    end.