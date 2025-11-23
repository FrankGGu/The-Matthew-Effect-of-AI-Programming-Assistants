-module(total_appeal_of_a_string).
-export([appeal_sum/1]).

appeal_sum(Str) ->
    appeal_sum(Str, 0, 0, dict:new()).

appeal_sum([], _Index, Total, _LastPos) ->
    Total;
appeal_sum([Char | Rest], Index, Total, LastPos) ->
    Prev = dict:find(Char, LastPos, -1),
    NewTotal = Total + (Index - Prev),
    NewLastPos = dict:store(Char, Index, LastPos),
    appeal_sum(Rest, Index + 1, NewTotal, NewLastPos).