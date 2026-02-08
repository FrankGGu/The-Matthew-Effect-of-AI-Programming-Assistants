-module(random_pick_index).
-export([new/1, pick/2]).

-type state() :: #{num_map := #{integer() => [integer()]}}.

new(Nums) ->
    NumMap = lists:foldl(
        fun(Num, Acc) ->
            case maps:find(Num, Acc) of
                {ok, Indices} ->
                    maps:put(Num, Indices ++ [length(Acc)], Acc);
                error ->
                    maps:put(Num, [length(Acc)], Acc)
            end
        end,
        #{},
        Nums
    ),
    #{num_map => NumMap}.

pick(Obj, Target) ->
    NumMap = maps:get(num_map, Obj),
    Indices = maps:get(Target, NumMap),
    lists:nth(rand:uniform(length(Indices)), Indices) - 1.