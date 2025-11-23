-module(solution).
-export([makeArrayIncreasing/2]).

makeArrayIncreasing(Arr1, Arr2) ->
    Arr2SortedUnique = lists:usort(Arr2),
    Arr2Tree = gb_trees:from_list(lists:map(fun(X) -> {X, X} end, Arr2SortedUnique)),

    Dp = #{0 => -1},

    FinalDp = lists:foldl(
        fun(Num1, CurrentDp) ->
            NextDp = maps:fold(
                fun(Ops, PrevVal, AccNextDp) ->
                    AccNextDp1 = 
                        if Num1 > PrevVal ->
                            update_min(AccNextDp, Ops, Num1);
                        true ->
                            AccNextDp
                        end,

                    case gb_trees:next(Arr2Tree, PrevVal) of
                        {Val2, _} ->
                            update_min(AccNextDp1, Ops + 1, Val2);
                        _ ->
                            AccNextDp1
                    end
                end,
                #{},
                CurrentDp
            ),
            NextDp
        end,
        Dp,
        Arr1
    ),

    case maps:is_empty(FinalDp) of
        true ->
            -1;
        false ->
            lists:min(maps:keys(FinalDp))
    end.

update_min(Map, Key, Value) ->
    case maps:find(Key, Map) of
        {ok, OldValue} ->
            maps:update(Key, min(OldValue, Value), Map);
        error ->
            maps:put(Key, Value, Map)
    end.