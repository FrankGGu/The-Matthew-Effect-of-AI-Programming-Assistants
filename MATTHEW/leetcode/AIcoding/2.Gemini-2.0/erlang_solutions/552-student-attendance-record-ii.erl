-module(student_attendance_record_ii).
-export([check_record/1]).

check_record(N) ->
    check_record(N, 0, 0, 0, 1000000007).

check_record(0, _, _, _, _) ->
    1;
check_record(N, A, L, T, Mod) ->
    case N of
        0 ->
            1;
        _ ->
            check_record(N - 1, A, 0, T, Mod) +
            (case A < 1 of
                true -> check_record(N - 1, A + 1, 0, T, Mod);
                false -> 0
            end) +
            (case L < 2 of
                true -> check_record(N - 1, A, L + 1, T, Mod);
                false -> 0
            end) rem Mod
    end.