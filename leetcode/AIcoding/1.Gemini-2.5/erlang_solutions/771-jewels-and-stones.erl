-module(solution).
-export([numJewelsInStones/2]).

numJewelsInStones(Jewels, Stones) ->
    lists:foldl(fun(Stone, Count) ->
                    case lists:member(Stone, Jewels) of
                        true -> Count + 1;
                        false -> Count
                    end
                end, 0, Stones).