-module(solution).
-export([has_all_codes/2]).

has_all_codes(S, K) ->
    CodesNeeded = 2 bsl K,
    CodesFound = maps:from_list(lists:map(fun(X) -> {X, true} end, lists:seq(0, CodesNeeded - 1))),
    Length = string:length(S),
    F = fun(X) -> 
        {ok, Bin} = string:to_integer(X, 2),
        case maps:is_key(Bin, CodesFound) of
            true -> maps:remove(Bin, CodesFound);
            false -> CodesFound
        end
    end,
    lists:foldl(F, CodesFound, lists:map(fun i -> string:substr(S, i, K) end, lists:seq(0, Length - K)) ),
    maps:size(CodesFound) =:= 0.