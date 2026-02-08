-module(solution).
-export([matrixSumQueries/2]).

matrixSumQueries(N, Queries) ->
    InitialState = {0, 0, 0, gb_sets:empty(), gb_sets:empty()},
    ReversedQueries = lists:reverse(Queries),
    solve(N, ReversedQueries, InitialState).

solve(N, [], {AccSum, _, _, _, _}) ->
    AccSum;
solve(N, [[Type, Index, Val] | RestQueries], {AccSum, AccRowsSetCount, AccColsSetCount, RowsSeenSet, ColsSeenSet}) ->
    if AccRowsSetCount == N and AccColsSetCount == N ->
        AccSum;
    true ->
        NewState = 
            if
                Type == 0 ->
                    if
                        gb_sets:is_member(Index, RowsSeenSet) ->
                            {AccSum, AccRowsSetCount, AccColsSetCount, RowsSeenSet, ColsSeenSet};
                        true ->
                            Contribution = Val * (N - AccColsSetCount),
                            NewRowsSeenSet = gb_sets:add_element(Index, RowsSeenSet),
                            NewRowsSetCount = AccRowsSetCount + 1,
                            {AccSum + Contribution, NewRowsSetCount, AccColsSetCount, NewRowsSeenSet, ColsSeenSet}
                    end;
                Type == 1 ->
                    if
                        gb_sets:is_member(Index, ColsSeenSet) ->
                            {AccSum, AccRowsSetCount, AccColsSetCount, RowsSeenSet, ColsSeenSet};
                        true ->
                            Contribution = Val * (N - AccRowsSetCount),
                            NewColsSeenSet = gb_sets:add_element(Index, ColsSeenSet),
                            NewColsSetCount = AccColsSetCount + 1,
                            {AccSum + Contribution, AccRowsSetCount, NewColsSetCount, RowsSeenSet, NewColsSeenSet}
                    end
            end,
        solve(N, RestQueries, NewState)
    end.