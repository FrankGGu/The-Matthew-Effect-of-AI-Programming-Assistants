-module(solution).
-export([find_m_k_average/3]).

find_m_k_average(Nums, M, K) ->
    find_m_k_average(Nums, M, K, 0, [], [], 0, 0, []).

find_m_k_average([], _, _, _, _, _, _, _, _) -> [];
find_m_k_average([H | T], M, K, Index, Lower, Middle, Total, Count, Result) ->
    case Index < M of
        true ->
            insert(H, Lower, Middle, Total, Count),
            find_m_k_average(T, M, K, Index + 1, Lower, Middle, Total, Count, Result);
        false ->
            {NewLower, NewMiddle, NewTotal} = remove(H, Lower, Middle, Total),
            {NewLower2, NewMiddle2, NewTotal2} = insert(H, NewLower, NewMiddle, NewTotal, Count),
            case Count >= M of
                true ->
                    Avg = round(NewTotal2 / (M - 2 * K)),
                    find_m_k_average(T, M, K, Index + 1, NewLower2, NewMiddle2, NewTotal2, Count + 1, [Avg | Result]);
                false ->
                    find_m_k_average(T, M, K, Index + 1, NewLower2, NewMiddle2, NewTotal2, Count + 1, Result)
            end
    end.

insert(X, Lower, Middle, Total, Count) ->
    case length(Middle) < K of
        true ->
            {lists:sort([X | Lower]), Middle, Total + X};
        false ->
            Mid = lists:nth(K, Middle),
            if
                X < Mid ->
                    {lists:sort([X | Lower]), lists:sublist(Middle, K) ++ [Mid | lists:nthtail(K + 1, Middle)], Total + X};
                true ->
                    {lists:sort(Lower), lists:sublist(Middle, K) ++ [X | lists:nthtail(K + 1, Middle)], Total + X}
            end
    end.

remove(X, Lower, Middle, Total) ->
    case lists:member(X, Lower) of
        true ->
            {lists:delete(X, Lower), Middle, Total - X};
        false ->
            case lists:member(X, Middle) of
                true ->
                    {Lower, lists:delete(X, Middle), Total - X};
                false ->
                    {Lower, Middle, Total}
            end
    end.