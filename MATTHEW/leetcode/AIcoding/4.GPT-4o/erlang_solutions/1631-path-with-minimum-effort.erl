-module(solution).
-export([minimum_effort_path/1]).

minimum_effort_path(heights) ->
    Rows = length(heights),
    Cols = length(hd(heights)),
    Efforts = lists:duplicate(Rows, lists:duplicate(Cols, infinity)),
    Efforts1 = lists:replace(Efforts, 1, lists:replace(hd(Efforts), 1, 0)),
    Path = minimum_effort(heights, Efforts1, 1, 1, Rows, Cols),
    lists:last(lists:last(Path)).

minimum_effort(_, Efforts, Row, Col, Rows, Cols) when Row > Rows, Col > Cols -> 
    Efforts;
minimum_effort(Heights, Efforts, Row, Col, Rows, Cols) -> 
    if Row =< Rows, Col =< Cols -> 
        CurrentEffort = lists:nth(Row, lists:nth(Col, Heights)),
        Neighbors = [{Row + 1, Col}, {Row - 1, Col}, {Row, Col + 1}, {Row, Col - 1}],
        NewEfforts = lists:foldl(fun({R, C}, Acc) -> 
            if R > 0, R =< Rows, C > 0, C =< Cols -> 
                NewEffort = max(0, abs(CurrentEffort - lists:nth(R, lists:nth(C, Heights)))) + lists:nth(R, lists:nth(C, Acc)),
                if NewEffort < lists:nth(R, lists:nth(C, Acc)) -> 
                    lists:replace(Acc, R, lists:replace(lists:nth(R, Acc), C, NewEffort));
                true -> 
                    Acc
                end;
            true -> 
                Acc
            end
        end, Efforts, Neighbors),
        minimum_effort(Heights, NewEfforts, Row, Col + 1, Rows, Cols);
    true -> 
        Efforts
    end.