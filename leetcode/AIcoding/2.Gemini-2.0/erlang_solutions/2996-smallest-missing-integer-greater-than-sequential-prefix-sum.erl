-module(smallest_missing_integer).
-export([smallest_missing_integer/1]).

smallest_missing_integer(Nums) ->
    smallest_missing_integer(Nums, 1, 0).

smallest_missing_integer([], Start, _) ->
    Start;
smallest_missing_integer([H|T], Start, Sum) ->
    case Sum + H >= Start of
        true ->
            smallest_missing_integer(T, Start + 1, Sum + H);
        false ->
            Start
    end.