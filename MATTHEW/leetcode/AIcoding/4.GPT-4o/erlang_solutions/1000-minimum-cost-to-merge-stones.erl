-module(solution).
-export([merge_stones/1]).

merge_stones(Stones) ->
    N = length(Stones),
    case N of
        1 -> 0;
        _ -> 
            Total = lists:sum(Stones),
            merge(Stones, N, Total, 0, #{})
    end.

merge(Stones, N, Total, Cost, Memo) ->
    case maps:get({N, 0}, Memo, undefined) of
        undefined ->
            NewCost = case N rem 2 of
                0 -> 
                    NewCost = Cost + Total + (N - 1) * (N - 1),
                    UpdatedMemo = maps:put({N, 0}, NewCost, Memo),
                    merge(Stones, N - 1, Total, NewCost, UpdatedMemo);
                _ ->
                    NewCost = Cost + Total,
                    UpdatedMemo = maps:put({N, 0}, NewCost, Memo),
                    merge(Stones, N - 1, Total, NewCost, UpdatedMemo)
            end,
            NewCost;
        Cost -> 
            Cost
    end.