-module(find_trigger_time).
-export([get_trigger_time/2]).

get_trigger_time(triggers, records) ->
    get_trigger_time(triggers, records, []).

get_trigger_time([], _, Acc) ->
    lists:reverse(Acc);
get_trigger_time([Trigger | RestTriggers], Records, Acc) ->
    Time = find_time(Trigger, Records, 0),
    get_trigger_time(RestTriggers, Records, [Time | Acc]).

find_time({C, I, R}, Records, Default) ->
    find_time({C, I, R}, Records, 0, Default).

find_time({C, I, R}, [], Acc, Default) ->
    Default;
find_time({C, I, R}, [{C0, I0, R0} | RestRecords], Acc, Default) ->
    C1 = C0 + (case Acc > 0 of true -> lists:nth(1,hd(lists:reverse(lists:sublist(lists:reverse(RestRecords),Acc)))) ; false -> 0 end),
    I1 = I0 + (case Acc > 0 of true -> lists:nth(2,hd(lists:reverse(lists:sublist(lists:reverse(RestRecords),Acc)))) ; false -> 0 end),
    R1 = R0 + (case Acc > 0 of true -> lists:nth(3,hd(lists:reverse(lists:sublist(lists:reverse(RestRecords),Acc)))) ; false -> 0 end),
    if
        (C1 >= C) and (I1 >= I) and (R1 >= R) ->
            Acc+1;
        true ->
            find_time({C, I, R}, RestRecords, Acc+1, Default)
    end.