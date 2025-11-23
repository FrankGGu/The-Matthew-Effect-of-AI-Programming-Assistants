-module(solution).
-export([min_index_sum/2]).

min_index_sum(List1, List2) ->
    Map1 = lists_to_map(List1, 0, #{}).

    ResultReversed = find_min_sum(List2, 0, Map1, infinity, []),
    lists:reverse(ResultReversed).

lists_to_map([], _Idx, Acc) -> Acc;
lists_to_map([H|T], Idx, Acc) ->
    lists_to_map(T, Idx + 1, maps:put(H, Idx, Acc)).

find_min_sum([], _Idx2, _Map1, _MinSum, ResultAcc) ->
    ResultAcc;
find_min_sum([H2|T2], Idx2, Map1, MinSum, ResultAcc) ->
    case maps:find(H2, Map1) of
        {ok, Idx1} ->
            CurrentSum = Idx1 + Idx2,
            if
                CurrentSum < MinSum ->
                    find_min_sum(T2, Idx2 + 1, Map1, CurrentSum, [H2]);
                CurrentSum == MinSum ->
                    find_min_sum(T2, Idx2 + 1, Map1, MinSum, [H2|ResultAcc]);
                true ->
                    find_min_sum(T2, Idx2 + 1, Map1, MinSum, ResultAcc)
            end;
        error ->
            find_min_sum(T2, Idx2 + 1, Map1, MinSum, ResultAcc)
    end.