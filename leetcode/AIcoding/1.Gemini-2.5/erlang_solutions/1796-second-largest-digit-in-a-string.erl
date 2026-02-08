-module(solution).
-export([second_largest_digit/1]).

second_largest_digit(S) ->
    {_Max1, Max2} = lists:foldl(
        fun(Char, {CurrentMax1, CurrentMax2}) ->
            if
                Char >= $0 andalso Char =< $9 ->
                    Digit = Char - $0,
                    if
                        Digit > CurrentMax1 ->
                            {Digit, CurrentMax1};
                        Digit < CurrentMax1 andalso Digit > CurrentMax2 ->
                            {CurrentMax1, Digit};
                        true ->
                            {CurrentMax1, CurrentMax2}
                    end;
                true ->
                    {CurrentMax1, CurrentMax2}
            end
        end,
        {-1, -1},
        string:to_list(S)
    ),
    Max2.