-module(two_out_of_three).
-export([two_out_of_three/1]).

two_out_of_three(Nums) ->
    Sets = lists:map(fun(N) -> sets:from_list(N) end, Nums),
    All = lists:foldl(fun(S, Acc) -> sets:union(S, Acc) end, sets:new(), Sets),
    lists:foldl(fun(S, Acc) -> 
        lists:foldl(fun(E, A) -> 
            case sets:is_element(E, S) of
                true -> 
                    case sets:is_element(E, Acc) of
                        true -> A;
                        false -> sets:add_element(E, A)
                    end;
                false -> A
            end
        end, sets:new(), sets:to_list(All))
    end, sets:new(), Sets),
    sets:to_list(sets:foldl(fun(E, Acc) -> sets:add_element(E, Acc) end, sets:new(), lists:foldl(fun(S, Acc) -> sets:union(S, Acc) end, sets:new(), Sets))).

two_out_of_three(Nums) ->
    Sets = lists:map(fun(N) -> sets:from_list(N) end, Nums),
    All = lists:foldl(fun(S, Acc) -> sets:union(S, Acc) end, sets:new(), Sets),
    Result = lists:foldl(fun(S, Acc) -> 
        lists:foldl(fun(E, A) -> 
            case sets:is_element(E, S) of
                true -> 
                    case sets:is_element(E, Acc) of
                        true -> A;
                        false -> sets:add_element(E, A)
                    end;
                false -> A
            end
        end, sets:new(), sets:to_list(All))
    end, sets:new(), Sets),
    sets:to_list(Result).