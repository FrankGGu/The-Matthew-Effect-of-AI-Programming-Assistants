-module(latest_time).
-export([maximum_time/1]).

maximum_time(TimeString) ->
    maximum_time(TimeString, 0).

maximum_time([], _) ->
    [];
maximum_time([H | T], Index) when Index == 0 ->
    case H of
        $? -> "2" ++ maximum_time(T, Index + 1);
        $H -> "3" ++ maximum_time(T, Index + 1);
        _ -> [H | maximum_time(T, Index + 1)]
    end;
maximum_time([H | T], Index) when Index == 1 ->
    case H of
        $? -> "3" ++ maximum_time(T, Index + 1);
        $H -> "9" ++ maximum_time(T, Index + 1);
        _ -> [H | maximum_time(T, Index + 1)]
    end;
maximum_time([H | T], Index) when Index == 2 ->
    case H of
        $? -> "5" ++ maximum_time(T, Index + 1);
        _ -> [H | maximum_time(T, Index + 1)]
    end;
maximum_time([H | T], Index) when Index == 3 ->
    case H of
        $? -> "9" ++ maximum_time(T, Index + 1);
        _ -> [H | maximum_time(T, Index + 1)]
    end.