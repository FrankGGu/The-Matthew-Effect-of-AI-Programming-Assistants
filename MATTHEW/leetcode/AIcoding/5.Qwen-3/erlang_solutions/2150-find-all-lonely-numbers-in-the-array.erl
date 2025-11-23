-module(solution).
-export([find_lonely_numbers/1]).

find_lonely_numbers(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> dict:update_counter(N, 1, Acc) end, dict:new(), Nums),
    lists:filter(fun(N) ->
        case dict:is_key(N, Count) of
            true ->
                case dict:fetch(N, Count) of
                    1 ->
                        case dict:is_key(N - 1, Count) of
                            false ->
                                case dict:is_key(N + 1, Count) of
                                    false -> true;
                                    _ -> false
                                end;
                            _ -> false
                        end;
                    _ -> false
                end;
            _ -> false
        end
    end, Nums).