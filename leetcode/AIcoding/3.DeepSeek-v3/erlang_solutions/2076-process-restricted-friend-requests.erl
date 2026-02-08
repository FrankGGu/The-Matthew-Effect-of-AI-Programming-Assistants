-module(solution).
-export([friend_requests/2]).

friend_requests(N, Restrictions) ->
    Parent = array:new([{size, N}, {default, -1}]),
    lists:map(fun([U, V]) -> 
                  case union(U, V, Parent) of
                      true -> 
                          case check_restriction(U, V, Restrictions, Parent) of
                              true -> false;
                              false -> true
                          end;
                      false -> true
                  end
              end, Restrictions).

find(X, Parent) ->
    case array:get(X, Parent) of
        -1 -> X;
        P -> 
            Root = find(P, Parent),
            array:set(X, Root, Parent),
            Root
    end.

union(X, Y, Parent) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if
        RootX =:= RootY -> false;
        true -> 
            array:set(RootY, RootX, Parent),
            true
    end.

check_restriction(U, V, Restrictions, Parent) ->
    lists:any(fun([A, B]) -> 
                  RootA = find(A, Parent),
                  RootB = find(B, Parent),
                  (RootA =:= find(U, Parent) andalso RootB =:= find(V, Parent)) orelse
                  (RootA =:= find(V, Parent) andalso RootB =:= find(U, Parent))
              end, Restrictions).