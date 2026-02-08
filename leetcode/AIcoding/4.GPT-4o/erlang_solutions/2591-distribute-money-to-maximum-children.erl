-module(solution).
-export([distribute_money/2]).

distribute_money(Money, Children) ->
    distribute_money(Money, Children, 0).

distribute_money(Money, 0, Count) -> 
    Count;
distribute_money(Money, Children, Count) -> 
    case Money >= Children * 2 of
        true -> 
            distribute_money(Money - 2 * Children, Children - 1, Count + 1);
        false -> 
            Count + Money div 2
    end.