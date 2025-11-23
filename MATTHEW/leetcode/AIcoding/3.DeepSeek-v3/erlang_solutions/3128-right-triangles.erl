-spec count_right_triangles(Points :: [[integer()]]) -> integer().
count_right_triangles(Points) ->
    Count = lists:foldl(fun(P, Acc) ->
        Maps = lists:foldl(fun(Q, M) ->
            case Q of
                P -> M;
                _ ->
                    DX = lists:nth(1, Q) - lists:nth(1, P),
                    DY = lists:nth(2, Q) - lists:nth(2, P),
                    G = gcd(DX, DY),
                    Key = {DX div G, DY div G},
                    maps:update_with(Key, fun(V) -> V + 1 end, 1, M)
            end
        end, #{}, Points),
        Perpendicular = maps:fold(fun({A, B}, V, Sum) ->
            case maps:get({-B, A}, Maps, 0) of
                0 -> Sum + maps:get({B, -A}, Maps, 0) * V;
                N -> Sum + N * V
            end
        end, 0, Maps),
        Acc + Perpendicular
    end, 0, Points),
    Count.

gcd(A, B) when B == 0 -> abs(A);
gcd(A, B) -> gcd(B, A rem B).