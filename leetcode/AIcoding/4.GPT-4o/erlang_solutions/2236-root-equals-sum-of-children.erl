-module(solution).
-export([check_equal/1]).

-record(node, {val, left = null, right = null}).

check_equal(Node) ->
    case Node of
        #node{val = Val, left = Left, right = Right} ->
            LeftVal = case Left of 
                          null -> 0; 
                          _ -> Left#node.val 
                      end,
            RightVal = case Right of 
                           null -> 0; 
                           _ -> Right#node.val 
                       end,
            Val =:= (LeftVal + RightVal)
    end.