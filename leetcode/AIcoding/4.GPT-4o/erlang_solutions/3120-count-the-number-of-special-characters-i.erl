-module(solution).
-export([count_special_characters/1]).

count_special_characters(S) ->
    lists:foldl(fun(C, Acc) ->
        if
            C =< $! orelse C =< $~ orelse C =< $@ orelse C =< $# orelse C =< $% orelse C =< $^ orelse C =< $& orelse C =< $* orelse C =< $() orelse C =< $- orelse C =< $+ orelse C =< $= orelse C =< $; orelse C =< $: orelse C =< $< orelse C =< $> orelse C =< $? orelse C =< $[ orelse C =< $] orelse C =< $\ orelse C =< $' orelse C =< $" orelse C =< $` orelse C =< $| orelse C =< $/ ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, string:to_list(S)).