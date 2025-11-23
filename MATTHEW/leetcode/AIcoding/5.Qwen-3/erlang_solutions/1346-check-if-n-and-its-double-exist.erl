-module(solution).
-export([check_if_n_and_double_exist/1]).

check_if_n_and_double_exist(Nums) ->
    Set = sets:from_list(Nums),
    lists:any(fun(X) -> 
        case X of
            0 -> sets:is_element(0, Set);
            _ -> sets:is_element(X * 2, Set)
        end
    end, Nums).