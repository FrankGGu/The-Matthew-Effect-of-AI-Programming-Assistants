-module(solution).
-export([init/1, pick_index/0]).

init(Weights) ->
    Sum = lists:sum(Weights),
    Prefix = lists:foldl(fun(W, Acc) -> [hd(Acc) + W | Acc] end, [0], Weights),
    {Sum, lists:reverse(Prefix)}.

pick_index() ->
    {Sum, Prefix} = get(),
    R = rand:uniform(Sum),
    pick(R, Prefix, 0, length(Prefix) - 2).

pick(R, Prefix, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    case lists:nth(Mid + 1, Prefix) of
        Val when Val < R ->
            pick(R, Prefix, Mid + 1, Right);
        _ ->
            pick(R, Prefix, Left, Mid - 1)
    end;
pick(_, Prefix, Left, _) ->
    Left.

get() ->
    case get(prefix) of
        undefined -> {0, []};
        Value -> Value
    end.

put(Value) ->
    put(prefix, Value).