-module(solution).
-export([advantage_count/2]).

advantage_count(A, B) ->
    {SortedA, SortedB} = {lists:sort(A), lists:sort(B)},
    {_, Result} = assign(SortedA, SortedB, [], []),
    reconstruct(A, B, Result).

assign([], [], Assigned, Unassigned) ->
    {Unassigned, Assigned};
assign([A | As], [B | Bs], Assigned, Unassigned) ->
    case A > B of
        true ->
            assign(As, Bs, [{B, A} | Assigned], Unassigned);
        false ->
            assign(As, Bs, Assigned, [A | Unassigned])
    end.

reconstruct(A, B, Result) ->
    Map = maps:from_list(Result),
    Unassigned = lists:sort([X || X <- A, not lists:member(X, maps:values(Map))]),
    reconstruct_helper(B, Map, Unassigned, []).

reconstruct_helper([], _, _, Acc) ->
    lists:reverse(Acc);
reconstruct_helper([B | Bs], Map, Unassigned, Acc) ->
    case maps:get(B, Map, undefined) of
        undefined ->
            [X | Rest] = Unassigned,
            reconstruct_helper(Bs, Map, Rest, [X | Acc]);
        Val ->
            reconstruct_helper(Bs, Map, Unassigned, [Val | Acc])
    end.