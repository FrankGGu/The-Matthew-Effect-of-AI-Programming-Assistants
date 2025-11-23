-module(solution).
-export([prison_after_n_days/2]).

prison_after_n_days(Cells, N) ->
    prison_after_n_days(Cells, N, dict:new()).

prison_after_n_days(Cells, 0, _) ->
    Cells;
prison_after_n_days(Cells, N, Seen) ->
    NextCells = next_day(Cells),
    case dict:is_key(Cells, Seen) of
        true -> 
            Period = N rem dict:size(Seen),
            prison_after_n_days(Cells, Period, Seen);
        false -> 
            Seen1 = dict.store(Cells, true, Seen),
            prison_after_n_days(NextCells, N - 1, Seen1)
    end.

next_day(Cells) ->
    [next_cell(Cells, I) || I <- lists:seq(0, length(Cells) - 1)].

next_cell(Cells, I) ->
    case I of
        0 -> 0;
        _ when I == length(Cells) - 1 -> 0;
        _ -> 
            case (lists:nth(I + 1, Cells), lists:nth(I - 1, Cells)) of
                {1, 1} -> 0;
                {0, 0} -> 0;
                _ -> 1
            end
    end.