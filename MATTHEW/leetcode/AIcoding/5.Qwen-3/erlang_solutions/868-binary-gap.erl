-module(binary_gap).
-export([binary_gap/1]).

binary_gap(N) ->
    binary_gap(N, 0, -1).

binary_gap(0, Max, _) ->
    Max;
binary_gap(N, Max, Last) ->
    Bit = N band 1,
    case Bit of
        1 ->
            if
                Last == -1 ->
                    binary_gap(N bsr 1, Max, 0);
                true ->
                    NewMax = max(Max, 0 - Last),
                    binary_gap(N bsr 1, NewMax, 0)
            end;
        0 ->
            binary_gap(N bsr 1, Max, Last + 1)
    end.