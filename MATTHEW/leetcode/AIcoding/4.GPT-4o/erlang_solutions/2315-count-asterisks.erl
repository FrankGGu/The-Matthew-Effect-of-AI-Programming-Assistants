-module(solution).
-export([count_asterisks/1]).

count_asterisks(S) ->
    count_asterisks(S, 0, false).

count_asterisks([], Count, _) -> 
    Count;
count_asterisks([H | T], Count, In_bar) -> 
    case H of
        $| -> count_asterisks(T, Count, not In_bar);
        $* when not In_bar -> count_asterisks(T, Count + 1, In_bar);
        _ -> count_asterisks(T, Count, In_bar)
    end.