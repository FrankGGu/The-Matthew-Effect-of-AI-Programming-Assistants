-module(solution).
-export([can_build/1]).

can_build(Blocks) ->
    case Blocks of
        [] -> true;
        _ ->
            Counts = lists:foldl(fun(Block, Acc) ->
                                    maps:update_with(Block, fun(V) -> V + 1 end, 1, Acc)
                                end, #{}, Blocks),
            lists:all(fun({_, C}) -> C rem 2 == 0 end, maps:to_list(Counts))
    end.