-module(solution).
-export([create_binary_tree/1]).

-record(node, {val, left = none, right = none}).

create_binary_tree(Descriptions) ->
    Nodes = lists:foldl(fun({P, C, IsLeft}, Acc) ->
        case maps:get(P, Acc, none) of
            none -> Acc1 = maps:put(P, #node{val = P}, Acc); Acc1 = Acc
        end,
        case maps:get(C, Acc1, none) of
            none -> Acc2 = maps:put(C, #node{val = C}, Acc1); Acc2 = Acc1
        end,
        case IsLeft of
            true -> 
                Acc2#node{left = maps:get(C, Acc2)}
            false -> 
                Acc2#node{right = maps:get(C, Acc2)}
        end
    end, maps:new(), Descriptions),
    maps:get(lists:hd(lists:map(fun({P, _, _}) -> P end, Descriptions)), Nodes).