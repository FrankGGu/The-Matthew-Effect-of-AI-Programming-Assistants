-module(solution).
-export([maximum_time/1]).

-spec maximum_time(Time :: unicode:unicode_binary()) -> unicode:unicode_binary().
maximum_time(TimeBin) ->
    TimeList = unicode:characters_to_list(TimeBin),
    [H1, H2, C, M1, M2] = TimeList,

    NewH1 = case H1 of
                $? ->
                    case H2 of
                        $? -> $2;
                        D2 when D2 >= $0, D2 =< $3 -> $2;
                        _ -> $1
                    end;
                _ -> H1
            end,

    NewH2 = case H2 of
                $? ->
                    case NewH1 of
                        $2 -> $3;
                        _ -> $9
                    end;
                _ -> H2
            end,

    NewM1 = case M1 of
                $? -> $5;
                _ -> M1
            end,

    NewM2 = case M2 of
                $? -> $9;
                _ -> M2
            end,

    unicode:characters_to_binary([NewH1, NewH2, C, NewM1, NewM2]).