-module(solution).
-export([grid_illumination/4]).

grid_illumination(N, Lamps, Queries) ->
    LampSet = sets:from_list(Lamps),
    Row = maps:new(),
    Col = maps:new(),
    Diag1 = maps:new(),
    Diag2 = maps:new(),
    {Row1, Col1, Diag11, Diag21} = lists:foldl(fun({X, Y}, {R, C, D1, D2}) ->
        R1 = maps:update_with(X, fun(V) -> V + 1 end, 1, R),
        C1 = maps:update_with(Y, fun(V) -> V + 1 end, 1, C),
        D11 = maps:update_with(X - Y, fun(V) -> V + 1 end, 1, D1),
        D21 = maps:update_with(X + Y, fun(V) -> V + 1 end, 1, D2),
        {R1, C1, D11, D21}
    end, {Row, Col, Diag1, Diag2}, Lamps),
    process_queries(Queries, N, LampSet, Row1, Col1, Diag11, Diag21, []).

process_queries([], _N, _LampSet, _Row, _Col, _Diag1, _Diag2, Acc) ->
    lists:reverse(Acc);
process_queries([{X, Y} | Rest], N, LampSet, Row, Col, Diag1, Diag2, Acc) ->
    Illuminated = case maps:is_key(X, Row) orelse maps:is_key(Y, Col) orelse
                    maps:is_key(X - Y, Diag1) orelse maps:is_key(X + Y, Diag2) of
                    true -> 1;
                    false -> 0
                  end,
    NewAcc = [Illuminated | Acc],
    {NewLampSet, NewRow, NewCol, NewDiag1, NewDiag2} = turn_off_adjacent(X, Y, N, LampSet, Row, Col, Diag1, Diag2),
    process_queries(Rest, N, NewLampSet, NewRow, NewCol, NewDiag1, NewDiag2, NewAcc).

turn_off_adjacent(X, Y, N, LampSet, Row, Col, Diag1, Diag2) ->
    Dx = [-1, -1, -1, 0, 0, 0, 1, 1, 1],
    Dy = [-1, 0, 1, -1, 0, 1, -1, 0, 1],
    lists:foldl(fun({Dxi, Dyi}, {LS, R, C, D1, D2}) ->
        NX = X + Dxi,
        NY = Y + Dyi,
        case NX >= 0 andalso NX < N andalso NY >= 0 andalso NY < N andalso sets:is_element({NX, NY}, LS) of
            true ->
                LS1 = sets:del_element({NX, NY}, LS),
                R1 = maps:update_with(NX, fun(V) -> V - 1 end, Row),
                R2 = case maps:get(NX, R1, 0) of
                        0 -> maps:remove(NX, R1);
                        _ -> R1
                     end,
                C1 = maps:update_with(NY, fun(V) -> V - 1 end, Col),
                C2 = case maps:get(NY, C1, 0) of
                        0 -> maps:remove(NY, C1);
                        _ -> C1
                     end,
                D11 = maps:update_with(NX - NY, fun(V) -> V - 1 end, Diag1),
                D12 = case maps:get(NX - NY, D11, 0) of
                        0 -> maps:remove(NX - NY, D11);
                        _ -> D11
                     end,
                D21 = maps:update_with(NX + NY, fun(V) -> V - 1 end, Diag2),
                D22 = case maps:get(NX + NY, D21, 0) of
                        0 -> maps:remove(NX + NY, D21);
                        _ -> D21
                     end,
                {LS1, R2, C2, D12, D22};
            false ->
                {LS, R, C, D1, D2}
        end
    end, {LampSet, Row, Col, Diag1, Diag2}, lists:zip(Dx, Dy)).