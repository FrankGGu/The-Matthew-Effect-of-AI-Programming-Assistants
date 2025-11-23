-module(solution).
-export([transformed_array/1]).

transformed_array(A) ->
    lists:map(fun(X) -> if
                            X < 0 -> 0;
                            X > 0 -> 1;
                            true -> 2
                        end
                end, A).