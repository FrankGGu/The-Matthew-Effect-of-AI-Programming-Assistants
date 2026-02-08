-module(solution).
-export([min_insertions/1]).

min_insertions(S) ->
    min_insertions(S, 0, 0).

min_insertions([], 0, Count) ->
    Count;
min_insertions([], Open, Count) when Open > 0 ->
    Count + 2 * Open;
min_insertions([H | T], Open, Count) ->
    case H of
        $'(' -> min_insertions(T, Open + 1, Count);
        $')' ->
            case Open of
                0 -> min_insertions(T, Open, Count + 1);
                _ -> min_insertions(T, Open - 1, Count)
            end;
        _ -> min_insertions(T, Open, Count)
    end.