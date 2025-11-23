-module(solution).
-export([num_friend_requests/1]).

num_friend_requests(Ages) ->
    lists:foldl(fun(A, Acc) ->
        Acc + lists:foldl(fun(B, InnerAcc) ->
            if
                B > A * 0.5 + 7, 
                B < A -> InnerAcc + 1;
                B >= A -> InnerAcc + 1;
                true -> InnerAcc
            end
        end, 0, Ages)
    end, 0, Ages).