-module(process_restricted_friend_requests).
-export([friend_requests/3]).

friend_requests(N, Restrictions, Requests) ->
  InitialFriends = gb_sets:empty(),
  foldl(fun(Req, {Friends, Acc}) ->
            case process_request(Req, Restrictions, Friends) of
              {true, NewFriends} -> {NewFriends, [true | Acc]};
              {false, _} -> {Friends, [false | Acc]}
            end
        end, {gb_sets:empty(), []}, Requests, N) ->
  lists:reverse(tl(lists:reverse(foldl(fun(Req, {Friends, Acc}) ->
            case process_request(Req, Restrictions, Friends) of
              {true, NewFriends} -> {NewFriends, [true | Acc]};
              {false, _} -> {Friends, [false | Acc]}
            end
        end, {gb_sets:empty(), []}, Requests, N) )).

process_request([A, B], Restrictions, Friends) ->
  A1 = min(A,B),
  B1 = max(A,B),
  Restricted = lists:any(fun([X, Y]) ->
                            X1 = min(X,Y),
                            Y1 = max(X,Y),
                            (X1 == A1 andalso Y1 == B1) orelse
                              (gb_sets:is_element(A, Friends) andalso gb_sets:is_element(X, Friends) andalso not connected(A,X,Friends, [A])) orelse
                              (gb_sets:is_element(A, Friends) andalso gb_sets:is_element(Y, Friends) andalso not connected(A,Y,Friends, [A])) orelse
                              (gb_sets:is_element(B, Friends) andalso gb_sets:is_element(X, Friends) andalso not connected(B,X,Friends, [B])) orelse
                              (gb_sets:is_element(B, Friends) andalso gb_sets:is_element(Y, Friends) andalso not connected(B,Y,Friends, [B]))
                         end, Restrictions),

  if Restricted ->
    {false, Friends}
  else
    NewFriends = gb_sets:add(A, gb_sets:add(B, Friends)),
    {true, NewFriends}
  end.

connected(A, B, Friends, Visited) ->
  if gb_sets:is_element(B, gb_sets:intersection(gb_sets:from_list(neighbors(A, Friends)), gb_sets:from_list([B]))) then
    true
  else
    Next = lists:filter(fun(N) -> not lists:member(N, Visited) end, neighbors(A, Friends)),
    lists:any(fun(N) -> connected(N, B, Friends, [N|Visited]) end, Next)
  end.

neighbors(A, Friends) ->
  gb_sets:to_list(gb_sets:filter(fun(X) -> X /= A andalso connected_directly(A,X,Friends) end, Friends)).

connected_directly(A, B, Friends) ->
  gb_sets:is_element(A, Friends) andalso gb_sets:is_element(B, Friends) andalso
    (gb_sets:is_element(A, gb_sets:from_list(neighbors(B,Friends))) orelse gb_sets:is_element(B, gb_sets:from_list(neighbors(A,Friends)))).