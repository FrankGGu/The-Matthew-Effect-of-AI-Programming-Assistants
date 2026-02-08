-module(friends_of_appropriate_ages).
-export([num_friends/1]).

num_friends(Ages) ->
    Count = lists:foldl(fun(Age, Acc) -> 
        case Age of
            A when A >= 14 ->
                lists:foldl(fun(B, C) -> 
                    if B > A div 2 + 7, B =< A -> C + 1;
                       true -> C
                    end
                end, 0, Ages);
            _ -> Acc
        end
    end, 0, Ages).