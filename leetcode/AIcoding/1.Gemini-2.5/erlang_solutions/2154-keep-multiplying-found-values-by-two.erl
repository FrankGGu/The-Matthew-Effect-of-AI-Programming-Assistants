-module(solution).
-export([find_final_value/2]).

-spec find_final_value(Nums :: [integer()], Original :: integer()) -> integer().
find_final_value(Nums, Original) ->
    case lists:member(Original, Nums) of
        true ->
            find_final_value(Nums, Original * 2);
        false ->
            Original
    end.