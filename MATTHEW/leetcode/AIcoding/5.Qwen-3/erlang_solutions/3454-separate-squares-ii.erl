-module(solution).
-export([has_square/1]).

has_square(List) ->
    has_square(List, 0, []).

has_square([], _, _) ->
    false;
has_square([H | T], Index, Seen) ->
    case lists:member(H * H, Seen) of
        true ->
            true;
        false ->
            has_square(T, Index + 1, [H * H | Seen])
    end.