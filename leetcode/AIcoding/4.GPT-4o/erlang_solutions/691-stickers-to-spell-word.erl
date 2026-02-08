-module(solution).
-export([min_stickers/2]).

min_stickers(Stickers, Target) ->
    N = length(Stickers),
    TargetCount = count_chars(Target),
    StickerCounts = [count_chars(Sticker) || Sticker <- Stickers],
    dp(StickerCounts, TargetCount, N).

dp(StickerCounts, TargetCount, N) ->
    memo = #{},
    min_stickers_helper(StickerCounts, TargetCount, memo, N).

min_stickers_helper(_, {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}, Memo, _) ->
    {ok, 0};
min_stickers_helper(StickerCounts, TargetCount, Memo, N) ->
    case maps:get(TargetCount, Memo, undefined) of
        undefined ->
            Min = lists:foldl(fun(Count, Acc) ->
                NewTarget = subtract(TargetCount, Count),
                case NewTarget of
                    {_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_} ->
                        Acc;
                    _ ->
                        case min_stickers_helper(StickerCounts, NewTarget, Memo, N) of
                            {ok, Res} -> min(Acc, Res + 1);
                            _ -> Acc
                        end
                end
            end, infinity, StickerCounts),
            maps:put(TargetCount, Min, Memo);
        {ok, Res} -> Res
    end.

count_chars(Str) ->
    Counts = lists:duplicate(26, 0),
    lists:foldl(fun(C, Acc) -> 
        case C of
            $a -> lists:replace(0, 1, Acc);
            $b -> lists:replace(1, 1, Acc);
            $c -> lists:replace(2, 1, Acc);
            $d -> lists:replace(3, 1, Acc);
            $e -> lists:replace(4, 1, Acc);
            $f -> lists:replace(5, 1, Acc);
            $g -> lists:replace(6, 1, Acc);
            $h -> lists:replace(7, 1, Acc);
            $i -> lists:replace(8, 1, Acc);
            $j -> lists:replace(9, 1, Acc);
            $k -> lists:replace(10, 1, Acc);
            $l -> lists:replace(11, 1, Acc);
            $m -> lists:replace(12, 1, Acc);
            $n -> lists:replace(13, 1, Acc);
            $o -> lists:replace(14, 1, Acc);
            $p -> lists:replace(15, 1, Acc);
            $q -> lists:replace(16, 1, Acc);
            $r -> lists:replace(17, 1, Acc);
            $s -> lists:replace(18, 1, Acc);
            $t -> lists:replace(19, 1, Acc);
            $u -> lists:replace(20, 1, Acc);
            $v -> lists:replace(21, 1, Acc);
            $w -> lists:replace(22, 1, Acc);
            $x -> lists:replace(23, 1, Acc);
            $y -> lists:replace(24, 1, Acc);
            $z -> lists:replace(25, 1, Acc);
        end
    end, Counts, Str).

subtract({A, B, C, D, E, F, G, H, I, J, K, L, M, N, O, P, Q, R, S, T, U, V, W, X, Y, Z}, {A1, B1, C1, D1, E1, F1, G1, H1, I1, J1, K1, L1, M1, N1, O1, P1, Q1, R1, S1, T1, U1, V1, W1, X1, Y1, Z1}) ->
    {max(0, A - A1), max(0, B - B1), max(0, C - C1), max(0, D - D1), max(0, E - E1), max(0, F - F1), max(0, G - G1), max(0, H - H1), max(0, I - I1), max(0, J - J1), max(0, K - K1), max(0, L - L1), max(0, M - M1), max(0, N - N1), max(0, O - O1), max(0, P - P1), max(0, Q - Q1), max(0, R - R1), max(0, S - S1), max(0, T - T1), max(0, U - U1), max(0, V - V1), max(0, W - W1), max(0, X - X1), max(0, Y - Y1), max(0, Z - Z1)}.