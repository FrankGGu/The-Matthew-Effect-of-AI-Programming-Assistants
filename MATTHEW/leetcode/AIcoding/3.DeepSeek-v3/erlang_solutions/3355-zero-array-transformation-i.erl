-module(solution).
-export([can_transform/1]).

can_transform(Nums) ->
    case lists:sum(Nums) of
        0 -> true;
        _ -> false
    end.