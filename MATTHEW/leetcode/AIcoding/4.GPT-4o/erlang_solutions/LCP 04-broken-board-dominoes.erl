-module(solution).
-export([max_dominoes/1]).

max_dominoes(Board) ->
    Max = length(Board),
    Dominoes = lists:foldl(fun({X, Y}, Acc) -> 
        case Acc of 
            [] -> [{X, Y}];
            [{B1, B2} | T] -> 
                if 
                    (X =:= B1 orelse X =:= B2 orelse Y =:= B1 orelse Y =:= B2) -> 
                        [{X, Y} | Acc];
                    true -> 
                        [{X, Y}, {B1, B2} | T]
                end
        end
    end, [], Board),
    length(Dominoes).