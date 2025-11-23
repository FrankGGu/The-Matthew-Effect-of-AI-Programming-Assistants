-module(solution).
-export([maximum_good/1]).

maximum_good(Statements) ->
    N = length(Statements),
    Max = (1 bsl N) - 1,
    lists:max([count_ones(Mask) || Mask <- lists:seq(0, Max), is_valid(Mask, Statements, N)]).

is_valid(Mask, Statements, N) ->
    lists:all(fun(I) ->
        case (Mask bsr I) band 1 of
            1 -> 
                lists:all(fun(J) ->
                    case (Mask bsr J) band 1 of
                        1 -> lists:nth(J + 1, lists:nth(I + 1, Statements)) =:= 1;
                        0 -> lists:nth(J + 1, lists:nth(I + 1, Statements)) =/= 0
                    end
                end, lists:seq(0, N - 1));
            0 -> true
        end
    end, lists:seq(0, N - 1)).

count_ones(Mask) ->
    count_ones(Mask, 0).
count_ones(0, Count) -> Count;
count_ones(Mask, Count) ->
    count_ones(Mask bsr 1, Count + (Mask band 1)).