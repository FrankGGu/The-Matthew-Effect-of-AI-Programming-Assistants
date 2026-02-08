-module(word_search).
-export([exist/2]).

exist(Board, Word) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    lists:foreach(fun(R) -> 
        lists:foreach(fun(C) -> 
            if 
                (lists:nth(R+1, Board) -- [lists:nth(C+1, lists:nth(R+1, Board))]) == [] -> 
                    case dfs(Board, Word, R, C, 0, []) of
                        true -> 
                            erlang:exit(true);
                        _ -> ok
                    end;
                true -> ok
            end
        end, lists:seq(0, Cols-1))
    end, lists:seq(0, Rows-1)),
    false.

dfs(_, _, _, _, Len, _) when Len == length(Word) -> true;
dfs(Board, Word, Row, Col, Pos, Visited) ->
    [R, C] = [Row, Col],
    [R1, C1] = [R+1, C], [R2, C2] = [R-1, C], [R3, C3] = [R, C+1], [R4, C4] = [R, C-1],
    CurrentChar = lists:nth(C+1, lists:nth(R+1, Board)),
    TargetChar = lists:nth(Pos+1, Word),
    if CurrentChar /= TargetChar -> false;
       true ->
            NewVisited = [[R, C] | Visited],
            case check(Board, R1, C1, NewVisited) of
                true -> dfs(Board, Word, R1, C1, Pos+1, NewVisited);
                false -> case check(Board, R2, C2, NewVisited) of
                            true -> dfs(Board, Word, R2, C2, Pos+1, NewVisited);
                            false -> case check(Board, R3, C3, NewVisited) of
                                        true -> dfs(Board, Word, R3, C3, Pos+1, NewVisited);
                                        false -> case check(Board, R4, C4, NewVisited) of
                                                    true -> dfs(Board, Word, R4, C4, Pos+1, NewVisited);
                                                    false -> false
                                                end
                                    end
                        end
            end
    end.

check(Board, Row, Col, Visited) ->
    Row >= 0 andalso Row < length(Board) andalso Col >= 0 andalso Col < length(hd(Board)) andalso not lists:member([Row, Col], Visited).