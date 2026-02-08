-module(solution).
-export([pick_gifts/2]).

pick_gifts(Gifts, K) ->
    lists:foldl(fun(_, Acc) -> 
        {Max, Rest} = lists:foldl(fun(X, {M, R}) -> 
            if 
                X > M -> {X, [M | R]};
                true -> {M, [X | R]}
            end 
        end, {0, []}, Acc),
        lists:sublist(Rest, K) ++ [Max]
    end, Gifts, lists:duplicate(K, 0).