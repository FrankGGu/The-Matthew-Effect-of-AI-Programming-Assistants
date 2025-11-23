-module(solution).
-export([num_times_changed/1]).

num_times_changed(BinStr) ->
    num_times_changed(BinStr, 0, 0).

num_times_changed([], _, Count) ->
    Count;
num_times_changed([H | T], Pos, Count) ->
    case H of
        $1 ->
            if Pos + 1 == Count + 1 -> % current position is the next expected
                num_times_changed(T, Pos + 1, Count + 1);
            true ->
                num_times_changed(T, Pos + 1, Count)
            end;
        _ ->
            num_times_changed(T, Pos + 1, Count)
    end.