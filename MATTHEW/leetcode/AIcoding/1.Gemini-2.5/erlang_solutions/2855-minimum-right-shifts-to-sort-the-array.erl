-module(solution).
-export([minimum_right_shifts/1]).

-spec minimum_right_shifts(Nums :: [integer()]) -> integer().
minimum_right_shifts(Nums) ->
    N = length(Nums),
    if N =< 1 ->
        0;
    true ->
        {DescentCount, DescentIdx} = count_descents(Nums, 0, 0, -1),
        case DescentCount of
            0 ->
                0;
            1 ->
                LastElem = lists:last(Nums),
                FirstElem = hd(Nums),
                if LastElem =< FirstElem ->
                    N - (DescentIdx + 1);
                true ->
                    -1
                end;
            _ ->
                -1
        end
    end.

count_descents([_], _CurrentIndex, DescentCount, DescentIndex) ->
    {DescentCount, DescentIndex};
count_descents([H1, H2 | T], CurrentIndex, DescentCount, DescentIndex) ->
    if H1 > H2 ->
        NewDescentCount = DescentCount + 1,
        if NewDescentCount > 1 ->
            {2, CurrentIndex};
        true ->
            count_descents([H2 | T], CurrentIndex + 1, NewDescentCount, CurrentIndex)
        end;
    true ->
        count_descents([H2 | T], CurrentIndex + 1, DescentCount, DescentIndex)
    end.