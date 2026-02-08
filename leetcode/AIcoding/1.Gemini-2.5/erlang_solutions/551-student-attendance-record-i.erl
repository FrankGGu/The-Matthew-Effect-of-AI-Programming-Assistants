-module(solution).
-export([check_record/1]).

check_record(Record) ->
    check_record_helper(Record, 0, 0).

check_record_helper([], _AbsenceCount, _ConsecutiveLateCount) ->
    true;
check_record_helper([$A|T], AbsenceCount, _ConsecutiveLateCount) ->
    NewAbsenceCount = AbsenceCount + 1,
    if NewAbsenceCount >= 2 ->
        false;
    true ->
        check_record_helper(T, NewAbsenceCount, 0)
    end;
check_record_helper([$L|T], AbsenceCount, ConsecutiveLateCount) ->
    NewConsecutiveLateCount = ConsecutiveLateCount + 1,
    if NewConsecutiveLateCount >= 3 ->
        false;
    true ->
        check_record_helper(T, AbsenceCount, NewConsecutiveLateCount)
    end;
check_record_helper([$P|T], AbsenceCount, _ConsecutiveLateCount) ->
    check_record_helper(T, AbsenceCount, 0).