-module(solution).
-export([stoneGameIX/1]).

stoneGameIX(Stones) ->
    Counts = lists:foldl(fun(X, Acc) ->
                            case X rem 3 of
                                0 -> maps:update_with(0, fun(V) -> V + 1 end, 1, Acc);
                                1 -> maps:update_with(1, fun(V) -> V + 1 end, 1, Acc);
                                2 -> maps:update_with(2, fun(V) -> V + 1 end, 1, Acc)
                            end
                         end, #{0 => 0, 1 => 0, 2 => 0}, Stones),
    C0 = maps:get(0, Counts),
    C1 = maps:get(1, Counts),
    C2 = maps:get(2, Counts),
    case (C1 > 0 andalso C2 > 0) orelse (C0 rem 2 =/= 0 andalso (C1 > 2 orelse C2 > 2)) of
        true -> true;
        false -> false
    end.