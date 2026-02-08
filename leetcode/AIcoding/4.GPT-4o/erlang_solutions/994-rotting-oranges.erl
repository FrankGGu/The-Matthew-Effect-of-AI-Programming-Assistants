-module(solution).
-export([orangesRotting/1]).

orangesRotting(Grid) ->
    case find_rotten_and_count(Grid) of
        {Rotten, Fresh} -> 
            case Fresh of
                0 -> 0;
                _ -> 
                    Seconds = rot_oranges(Grid, Rotten, 0, Fresh),
                    case Seconds of
                        -1 -> -1;
                        _ -> Seconds
                    end
            end
    end.

find_rotten_and_count(Grid) ->
    {Rotten, Fresh} = lists:foldl(fun(Row, {R, F}) ->
        lists:foldl(fun(Cell, {R, F}) ->
            case Cell of
                2 -> {{R ++ [{Row, Column}], F} = {(Row, Column), F + 1}};
                1 -> {R, F + 1};
                _ -> {R, F}
            end
        end, {R, F}, Row)
    end, {[], 0}, Grid),
    {Rotten, Fresh}.

rot_oranges(Grid, Rotten, Seconds, Fresh) ->
    case Rotten of
        [] -> if Fresh == 0 -> Seconds; true -> -1 end;
        _ -> 
            NewRotten = lists:flatmap(fun({Row, Col}) -> 
                [{Row + 1, Col}, {Row - 1, Col}, {Row, Col + 1}, {Row, Col - 1}]
                end, Rotten),
            {NewRotten, FreshCount} = lists:foldl(fun({R, C}, {N, F}) ->
                if R < 0 orelse R >= length(Grid) orelse C < 0 orelse C >= length(hd(Grid)) -> {N, F};
                case lists:nth(R + 1, Grid) of
                    {_, _, _} -> 
                        case lists:nth(C + 1, lists:nth(R + 1, Grid)) of
                            1 -> 
                                {N ++ [{R + 1, C}], F - 1};
                            _ -> {N, F}
                        end;
                    _ -> {N, F}
                end
                end, {[], Fresh}, NewRotten),
            rot_oranges(Grid, NewRotten, Seconds + 1, FreshCount)
    end.