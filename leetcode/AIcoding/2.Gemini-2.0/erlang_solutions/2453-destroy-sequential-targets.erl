-module(destroy_targets).
-export([destroyTargets/2]).

destroyTargets(Nums, Space) ->
    destroyTargets(Nums, Space, #{}, 0, 0).

destroyTargets([], _, _, MaxCount, MinVal) ->
    case MaxCount > 0 of
        true -> MinVal;
        false -> 0
    end;

destroyTargets([H|T], Space, Counts, MaxCount, MinVal) ->
    Rem = H rem Space,
    NewCounts = maps:update_with(Rem, fun(X) -> X + 1 end, 1, Counts),
    NewCount = maps:get(Rem, NewCounts),
    case NewCount > MaxCount of
        true ->
            destroyTargets(T, Space, NewCounts, NewCount, H);
        false ->
            case NewCount == MaxCount of
                true ->
                    case H < MinVal of
                        true ->
                            destroyTargets(T, Space, NewCounts, MaxCount, H);
                        false ->
                            destroyTargets(T, Space, NewCounts, MaxCount, MinVal)
                    end;
                false ->
                    destroyTargets(T, Space, NewCounts, MaxCount, MinVal)
            end
    end.