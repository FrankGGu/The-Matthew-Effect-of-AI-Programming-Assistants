-module(solution).
-export([maximumGoodPeople/1]).

maximumGoodPeople(StatementsList) ->
    N = length(StatementsList),
    StatementsTuple = list_to_tuple([list_to_tuple(Row) || Row <- StatementsList]),
    MaxMask = (1 bsl N) - 1,
    find_max_good(0, MaxMask, StatementsTuple, N, 0).

find_max_good(CurrentMask, MaxMask, StatementsTuple, N, CurrentMax) when CurrentMask > MaxMask ->
    CurrentMax;
find_max_good(CurrentMask, MaxMask, StatementsTuple, N, CurrentMax) ->
    case is_valid_config(CurrentMask, StatementsTuple, N) of
        true ->
            GoodCount = count_set_bits(CurrentMask),
            NewMax = max(CurrentMax, GoodCount),
            find_max_good(CurrentMask + 1, MaxMask, StatementsTuple, N, NewMax);
        false ->
            find_max_good(CurrentMask + 1, MaxMask, StatementsTuple, N, CurrentMax)
    end.

is_valid_config(Mask, StatementsTuple, N) ->
    IsGoodTuple = list_to_tuple([((Mask bshr I) band 1) == 1 || I <- lists:seq(0, N-1)]),

    check_statements(0, N, StatementsTuple, IsGoodTuple).

check_statements(I, N, _StatementsTuple, _IsGoodTuple) when I == N ->
    true;
check_statements(I, N, StatementsTuple, IsGoodTuple) ->
    case element(I + 1, IsGoodTuple) of
        true ->
            PersonIStatementsTuple = element(I + 1, StatementsTuple),
            case check_person_statements(0, N, PersonIStatementsTuple, IsGoodTuple) of
                true ->
                    check_statements(I + 1, N, StatementsTuple, IsGoodTuple);
                false ->
                    false
            end;
        false ->
            check_statements(I + 1, N, StatementsTuple, IsGoodTuple)
    end.

check_person_statements(J, N, _PersonIStatementsTuple, _IsGoodTuple) when J == N ->
    true;
check_person_statements(J, N, PersonIStatementsTuple, IsGoodTuple) ->
    Statement_IJ = element(J + 1, PersonIStatementsTuple),
    case Statement_IJ of
        0 ->
            case element(J + 1, IsGoodTuple) of
                true -> false;
                false -> check_person_statements(J + 1, N, PersonIStatementsTuple, IsGoodTuple)
            end;
        1 ->
            case element(J + 1, IsGoodTuple) of
                true -> check_person_statements(J + 1, N, PersonIStatementsTuple, IsGoodTuple);
                false -> false
            end;
        2 ->
            check_person_statements(J + 1, N, PersonIStatementsTuple, IsGoodTuple)
    end.

count_set_bits(N) ->
    count_set_bits(N, 0).

count_set_bits(0, Count) ->
    Count;
count_set_bits(N, Count) ->
    count_set_bits(N band (N - 1), Count + 1).