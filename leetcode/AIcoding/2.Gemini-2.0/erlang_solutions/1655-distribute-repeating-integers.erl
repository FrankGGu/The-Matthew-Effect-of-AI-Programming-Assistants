-module(distribute_repeating_integers).
-export([can_distribute/2]).

can_distribute(Nums, Quantity) ->
    Counts = lists:foldl(fun(Num, Acc) ->
        case maps:is_key(Num, Acc) of
            true -> maps:update(Num, maps:get(Num, Acc) + 1, Acc);
            false -> maps:put(Num, 1, Acc)
        end
    end, #{}, Nums),

    CountsList = maps:values(Counts),

    can_distribute_helper(CountsList, Quantity).

can_distribute_helper(Counts, []) ->
    true;
can_distribute_helper(Counts, [Q | Rest]) ->
    lists:any(fun(C) ->
        C >= Q andalso can_distribute_helper(Counts -- [C], Rest) orelse
        C >= Q andalso can_distribute_helper([X || X <- Counts, X /= C] ++ [C - Q], Rest)
    end, Counts);

can_distribute_helper(Counts, Quantity) when is_list(Counts), is_list(Quantity) ->
    can_distribute_helper(lists:sort(Counts), lists:sort(Quantity)).