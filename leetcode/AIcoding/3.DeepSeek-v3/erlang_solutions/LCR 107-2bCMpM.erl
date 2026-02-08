-spec update_matrix(Matrix :: [[integer()]]) -> [[integer()]].
update_matrix(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    Queue = queue:new(),
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],

    Dist = lists:map(fun(Row) ->
        lists:map(fun(Val) ->
            case Val of
                0 -> 0;
                _ -> infinity
            end
        end, Row)
    end, Matrix),

    {Queue1, Dist1} = lists:foldl(fun(R, {QAcc, DAcc}) ->
        lists:foldl(fun(C, {QAcc1, DAcc1}) ->
            case lists:nth(C + 1, lists:nth(R + 1, Matrix)) of
                0 ->
                    Q = queue:in({R, C}, QAcc1),
                    D = setnth(R + 1, DAcc1, setnth(C + 1, lists:nth(R + 1, DAcc1), 0)),
                    {Q, D};
                _ ->
                    {QAcc1, DAcc1}
            end
        end, {QAcc, DAcc}, lists:seq(0, Cols - 1))
    end, {Queue, Dist}, lists:seq(0, Rows - 1)),

    bfs(Queue1, Directions, Dist1, Rows, Cols).

bfs(Queue, Directions, Dist, Rows, Cols) ->
    case queue:is_empty(Queue) of
        true -> Dist;
        false ->
            {{value, {R, C}}, Queue1} = queue:out(Queue),
            lists:foldl(fun({Dr, Dc}, {QAcc, DAcc}) ->
                NR = R + Dr,
                NC = C + Dc,
                if
                    NR >= 0, NR < Rows, NC >= 0, NC < Cols ->
                        CurrDist = lists:nth(NC + 1, lists:nth(NR + 1, DAcc)),
                        NewDist = lists:nth(C + 1, lists:nth(R + 1, DAcc)) + 1,
                        if
                            NewDist < CurrDist ->
                                D = setnth(NR + 1, DAcc, setnth(NC + 1, lists:nth(NR + 1, DAcc), NewDist)),
                                Q = queue:in({NR, NC}, QAcc),
                                {Q, D};
                            true ->
                                {QAcc, DAcc}
                        end;
                    true ->
                        {QAcc, DAcc}
                end
            end, {Queue1, Dist}, Directions),
            bfs(Queue1, Directions, Dist, Rows, Cols)
    end.

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].