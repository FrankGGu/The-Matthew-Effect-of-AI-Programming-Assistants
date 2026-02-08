-module(solution).
-export([check_record/1]).

check_record(Record) ->
    ACount = lists:count($A, Record),
    PCount = lists:count($P, Record),
    ACount =< 1 andalso not lists:any(fun(X) -> X =:= $L end, lists:sublist(Record, 3)).