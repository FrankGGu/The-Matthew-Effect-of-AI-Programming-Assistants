-spec can_arrange(Arr :: [integer()], K :: integer()) -> boolean().
can_arrange(Arr, K) ->
    Counts = maps:new(),
    Pairs = lists:foldl(fun(N, Acc) ->
        Rem = (N rem K + K) rem K,
        maps:update_with(Rem, fun(V) -> V + 1 end, 1, Acc)
    end, Counts, Arr),
    check_pairs(Pairs, K).

check_pairs(Counts, K) ->
    case maps:size(Counts) of
        0 -> true;
        _ ->
            Rem = maps:keys(Counts),
            lists:all(fun(R) ->
                case R of
                    0 ->
                        maps:get(R, Counts, 0) rem 2 == 0;
                    _ ->
                        Needed = K - R,
                        case maps:get(R, Counts, 0) == maps:get(Needed, Counts, 0) of
                            true -> true;
                            false -> false
                        end
                end
            end, Rem)
    end.