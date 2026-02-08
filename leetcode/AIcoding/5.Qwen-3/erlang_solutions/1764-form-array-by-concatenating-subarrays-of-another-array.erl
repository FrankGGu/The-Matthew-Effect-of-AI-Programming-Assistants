-module(solution).
-export([can_form/2]).

can_form(Targets, Arrays) ->
    can_form(Targets, Arrays, 1).

can_form([], _Arrays, _) ->
    true;
can_form([Target | Rest], Arrays, Index) ->
    case find_subarray(Target, Arrays, Index) of
        false ->
            false;
        {ok, NewIndex} ->
            can_form(Rest, Arrays, NewIndex)
    end.

find_subarray(_, [], _) ->
    false;
find_subarray(Target, [Array | Rest], Index) ->
    case is_subarray(Target, Array) of
        true ->
            {ok, Index + 1};
        false ->
            find_subarray(Target, Rest, Index)
    end.

is_subarray([], _) ->
    true;
is_subarray(_, []) ->
    false;
is_subarray([H | T], [H | Tt]) ->
    is_subarray(T, Tt);
is_subarray([H | T], [_ | Tt]) ->
    is_subarray([H | T], Tt).