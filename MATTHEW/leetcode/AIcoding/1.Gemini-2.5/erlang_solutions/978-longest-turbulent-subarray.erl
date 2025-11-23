-module(solution).
-export([longestTurbulentSubarray/1]).

longestTurbulentSubarray(Arr) ->
    Len = length(Arr),
    if
        Len =< 1 -> Len;
        true ->
            [_H | T] = Arr,
            {MaxLen, _Inc, _Dec, _PrevVal} = lists:foldl(
                fun(CurrentVal, {AccMaxLen, AccInc, AccDec, PrevVal}) ->
                    NewMaxLen = AccMaxLen,
                    NewInc = 1,
                    NewDec = 1,
                    if
                        PrevVal > CurrentVal ->
                            % Current segment ends with a decrease (PrevVal > CurrentVal)
                            % To extend a turbulent sequence, the previous segment must have ended with an increase.
                            CalculatedDec = AccInc + 1,
                            {max(NewMaxLen, CalculatedDec), 1, CalculatedDec};
                        PrevVal < CurrentVal ->
                            % Current segment ends with an increase (PrevVal < CurrentVal)
                            % To extend a turbulent sequence, the previous segment must have ended with a decrease.
                            CalculatedInc = AccDec + 1,
                            {max(NewMaxLen, CalculatedInc), CalculatedInc, 1};
                        true -> % PrevVal == CurrentVal, turbulence breaks
                            {NewMaxLen, 1, 1}
                    end,
                    CurrentVal
                end,
                {1, 1, 1, hd(Arr)}, % Initial: {MaxLen, Inc, Dec, PrevVal}
                T
            ),
            MaxLen
    end.