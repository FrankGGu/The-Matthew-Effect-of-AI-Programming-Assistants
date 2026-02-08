-module(max_good_people_based_on_statements).
-export([max_good_people/1]).

max_good_people(Statements) ->
    N = length(Statements),
    MaxGood = 0,
    find_max_good(0, N, Statements, MaxGood).

find_max_good(_, _, _, MaxGood) when MaxGood == N -> MaxGood;
find_max_good(Bitmask, N, Statements, MaxGood) ->
    Good = get_good_people(Bitmask, N),
    if
        Good > MaxGood ->
            NewMax = check_validity(Good, Statements, Bitmask),
            find_max_good(Bitmask + 1, N, Statements, NewMax);
        true ->
            find_max_good(Bitmask + 1, N, Statements, MaxGood)
    end.

get_good_people(Bitmask, N) ->
    count_ones(Bitmask, N).

count_ones(_, 0) -> 0;
count_ones(Bitmask, N) ->
    case (Bitmask band (1 bsl (N - 1))) of
        0 -> count_ones(Bitmask, N - 1);
        _ -> 1 + count_ones(Bitmask, N - 1)
    end.

check_validity(Good, Statements, Bitmask) ->
    Valid = true,
    check_validity_helper(0, Good, Statements, Bitmask, Valid).

check_validity_helper(_, _, _, _, false) -> 0;
check_validity_helper(I, Good, Statements, Bitmask, Valid) when I >= Good ->
    Good;
check_validity_helper(I, Good, Statements, Bitmask, Valid) ->
    case (Bitmask band (1 bsl I)) of
        0 -> check_validity_helper(I + 1, Good, Statements, Bitmask, Valid);
        _ ->
            Stmt = lists:nth(I + 1, Statements),
            Validity = check_statements(I, Stmt, Bitmask),
            check_validity_helper(I + 1, Good, Statements, Bitmask, Valid andalso Validity)
    end.

check_statements(I, Stmt, Bitmask) ->
    check_statements_helper(0, Stmt, I, Bitmask).

check_statements_helper(_, [], _, _) -> true;
check_statements_helper(J, [S | T], I, Bitmask) ->
    case S of
        0 ->
            if
                (Bitmask band (1 bsl J)) /= 0 -> false;
                true -> check_statements_helper(J + 1, T, I, Bitmask)
            end;
        1 ->
            if
                (Bitmask band (1 bsl J)) == 0 -> false;
                true -> check_statements_helper(J + 1, T, I, Bitmask)
            end
    end.