-module(solution).
-export([advantage_count/2]).

advantage_count(A, B) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    advantage_count_helper(SortedA, SortedB, []).

advantage_count_helper([], [], Acc) -> 
    lists:reverse(Acc);
advantage_count_helper([H|T], [B|Bs], Acc) ->
    case lists:filter(fun(X) -> X > B end, [H|T]) of
        [] -> 
            advantage_count_helper(T, Bs, [H | Acc]);
        [X | _] -> 
            advantage_count_helper(lists:delete(X, [H|T]), Bs, [X | Acc])
    end.