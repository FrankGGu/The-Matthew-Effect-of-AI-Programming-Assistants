-module(distribute_candies).
-export([distribute_candies/2]).

distribute_candies(Num, People) ->
    distribute_candies(Num, People, 1, 1, lists:duplicate(People, 0)).

distribute_candies(0, _, _, _, Result) ->
    Result;
distribute_candies(Num, People, Step, Candies, Result) ->
    Take = min(Candies, Num),
    Index = (Step - 1) rem People,
    NewResult = lists:sublist(Result, Index) ++ [lists:nth(Index + 1, Result) + Take] ++ lists:sublist(Result, Index + 1, length(Result) - Index - 1),
    distribute_candies(Num - Take, People, Step + 1, Candies + 1, NewResult).