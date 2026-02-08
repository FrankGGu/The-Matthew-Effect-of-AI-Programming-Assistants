-module(solution).
-export([binary_gap/1]).

binary_gap(N) ->
    BinString = integer_to_list(N, 2),
    binary_gap_helper(BinString, 0, -1, 0).

binary_gap_helper([], _CurrentIndex, _LastOneIndex, MaxGap) ->
    MaxGap;
binary_gap_helper([H|T], CurrentIndex, LastOneIndex, MaxGap) ->
    case H of
        $1 ->
            NewMaxGap = case LastOneIndex of
                            -1 -> MaxGap;
                            _  -> max(MaxGap, CurrentIndex - LastOneIndex)
                        end,
            binary_gap_helper(T, CurrentIndex + 1, CurrentIndex, NewMaxGap);
        $0 ->
            binary_gap_helper(T, CurrentIndex + 1, LastOneIndex, MaxGap)
    end.