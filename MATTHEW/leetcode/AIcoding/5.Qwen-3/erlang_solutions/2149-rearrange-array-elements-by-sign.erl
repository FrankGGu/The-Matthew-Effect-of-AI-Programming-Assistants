-module(rearrange_array_elements_by_sign).
-export([rearrange/1]).

rearrange(Numbers) ->
    {Pos, Neg} = lists:partition(fun(X) -> X > 0 end, Numbers),
    merge(Pos, Neg).

merge([], []) ->
    [];
merge([H|T], []) ->
    [H|T];
merge([], [H|T]) ->
    [H|T];
merge([P|Pt], [N|Nt]) ->
    [P, N | merge(Pt, Nt)].