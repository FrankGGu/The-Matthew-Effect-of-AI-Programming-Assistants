-module(solution).
-export([maxScorePaths/1]).

maxScorePaths(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    MaxScore = array:new(),
    Paths = array:new(),
    lists:foldl(fun({Row, Acc}) ->
        lists:foldl(fun({Col, Val}, Acc2) ->
            case {Row, Col} of
                {N-1, M-1} ->
                    array:store({Row, Col}, {Val, 1}, Acc2);
                _ ->
                    {Score, Count} = case {Row + 1 < N, Col + 1 < M} of
                        {true, true} ->
                            {array:get({Row + 1, Col}, Acc2), array:get({Row, Col + 1}, Acc2)};
                        {true, false} ->
                            {array:get({Row + 1, Col}, Acc2), 0};
                        {false, true} ->
                            {0, array:get({Row, Col + 1}, Acc2)};
                        {false, false} ->
                            {0, 0}
                    end,
                    NewScore = Val + max(Score, Count),
                    NewCount = case NewScore of
                        Score -> array:get({Row + 1, Col}, Acc2) + array:get({Row, Col + 1}, Acc2);
                        Count -> array:get({Row + 1, Col}, Acc2)
                    end,
                    array:store({Row, Col}, {NewScore, NewCount}, Acc2)
            end
        end, Acc, lists:zip(lists:seq(0, M-1), lists:nth(Row + 1, Grid)))
    end, array:store({N-1, M-1}, {0, 0}, array:new()), lists:zip(lists:seq(0, N-1), Grid)),
    case array:get({0, 0}, MaxScore) of
        {Score, Count} -> {Score, Count}
    end.