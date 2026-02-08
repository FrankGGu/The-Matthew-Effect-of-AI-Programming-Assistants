-module(process_restricted_friend_requests).
-export([friend_request/1]).

friend_request(Restrictions) ->
    Friends = lists:foldl(fun({A, B}, Acc) -> 
        case lists:keymember(A, 1, Acc) of
            true -> 
                case lists:keymember(B, 1, Acc) of
                    true -> Acc;
                    false -> lists:keystore(B, 1, Acc, {B, []});
                    _ -> Acc
                end;
            false -> 
                lists:keystore(A, 1, Acc, {A, []})
        end
    end, [], Restrictions),
    Requests = lists:usort([ {A, B} || {A, Bs} <- Friends, B <- Bs ]),
    Requests.