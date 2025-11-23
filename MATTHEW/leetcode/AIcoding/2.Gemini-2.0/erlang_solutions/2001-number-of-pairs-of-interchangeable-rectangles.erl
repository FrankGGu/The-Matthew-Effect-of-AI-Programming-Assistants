-module(solution).
-export([num_rectangles/1]).

num_rectangles(Rectangles) ->
    F = fun({W, H}) -> W / H end,
    Ratios = lists:map(F, lists:map(fun([W, H]) -> {W, H} end, Rectangles)),
    Counts = lists:foldl(fun(Ratio, Acc) ->
                                    case maps:is_key(Ratio, Acc) of
                                        true -> maps:update(Ratio, maps:get(Ratio, Acc) + 1, Acc);
                                        false -> maps:put(Ratio, 1, Acc)
                                    end
                            end, #{}, Ratios),
    lists:foldl(fun({_, Count}, Sum) ->
                           if Count > 1 ->
                                   Sum + Count * (Count - 1) div 2
                           true ->
                                   Sum
                           end
                   end, 0, maps:to_list(Counts)).