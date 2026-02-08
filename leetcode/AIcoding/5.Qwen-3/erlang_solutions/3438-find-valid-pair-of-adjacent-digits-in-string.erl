-module(solution).
-export([has_valid_pair/1]).

has_valid_pair(S) ->
    has_valid_pair(S, 0).

has_valid_pair([], _) ->
    false;
has_valid_pair([C1, C2 | Rest], Index) ->
    case (C1 - $0) + (C2 - $0) of
        Sum when Sum >= 10 ->
            true;
        _ ->
            has_valid_pair([C2 | Rest], Index + 1)
    end;
has_valid_pair([_], _) ->
    false.