-module(solution).
-export([is_knight_tour/1]).

is_knight_tour(Board) ->
    Size = length(Board),
    Positions = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun({Val, Col}, Acc2) -> 
            if Val > 0 -> [{Val, {Row, Col}} | Acc2]; true -> Acc2 end
        end, Acc, lists:zip(Board, lists:seq(0, Size-1)))
    end, [], lists:seq(0, Size-1)),

    SortedPositions = lists:sort(fun({A, _}, {B, _}) -> A < B end, Positions),
    check_tour(SortedPositions, 1, {0, 0}).

check_tour([], _, _) -> true;
check_tour([{Step, Pos} | Rest], CurrentStep, LastPos) ->
    if Step /= CurrentStep -> false;
       true ->
           case is_valid_move(Pos, LastPos) of
               true -> check_tour(Rest, CurrentStep + 1, Pos);
               false -> false
           end
    end.

is_valid_move({R1, C1}, {R2, C2}) ->
    DR = abs(R1 - R2),
    DC = abs(C1 - C2),
    (DR == 2 andalso DC == 1) orelse (DR == 1 andalso DC == 2).