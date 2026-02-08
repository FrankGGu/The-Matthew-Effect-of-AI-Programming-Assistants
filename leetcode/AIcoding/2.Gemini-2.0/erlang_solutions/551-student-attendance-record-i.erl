-module(student_attendance_record_i).
-export([checkRecord/1]).

checkRecord(Record) ->
    checkRecord(Record, 0, 0).

checkRecord([], _, _) ->
    true;
checkRecord([H|T], Absent, Late) ->
    case H of
        'A' ->
            if Absent < 1 then
                checkRecord(T, Absent + 1, 0)
            else
                false
            end;
        'L' ->
            if Late < 2 then
                checkRecord(T, Absent, Late + 1)
            else
                false
            end;
        'P' ->
            checkRecord(T, Absent, 0)
    end.