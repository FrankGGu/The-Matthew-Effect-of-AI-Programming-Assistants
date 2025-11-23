-module(peak_element_ii).
-export([findPeakElement/1]).

findPeakElement(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    findPeak(Grid, 0, Rows - 1, 0, Cols - 1).

findPeak(Grid, Rlow, Rhigh, Clow, Chigh) ->
    Rmid = (Rlow + Rhigh) div 2,
    Cmid = (Clow + Chigh) div 2,
    Current = lists:nth(Rmid + 1, Grid) -- [Cmid],
    Left = if Clow < Cmid -> lists:nth(Rmid + 1, Grid) -- [Cmid - 1]; true -> -1 end,
    Right = if Chigh > Cmid -> lists:nth(Rmid + 1, Grid) -- [Cmid + 1]; true -> -1 end,
    Up = if Rlow < Rmid -> lists:nth(Rmid, Grid) -- [Cmid]; true -> -1 end,
    Down = if Rhigh > Rmid -> lists:nth(Rmid + 2, Grid) -- [Cmid]; true -> -1 end,

    if
        Current > Left, Current > Right, Current > Up, Current > Down -> {Rmid, Cmid};
        Current < Left -> findPeak(Grid, Rlow, Rhigh, Clow, Cmid - 1);
        Current < Right -> findPeak(Grid, Rlow, Rhigh, Cmid + 1, Chigh);
        Current < Up -> findPeak(Grid, Rlow, Rmid - 1, Clow, Chigh);
        true -> findPeak(Grid, Rmid + 1, Rhigh, Clow, Chigh)
    end.