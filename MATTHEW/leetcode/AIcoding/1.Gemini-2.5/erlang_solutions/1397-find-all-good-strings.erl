-module(solution).
-export([findGoodStrings/4]).

-include_lib("kernel/include/array.hrl").

findGoodStrings(N, S1, S2, Bad) ->
    Mod = 1_000_000_007,
    BadLen = length(Bad),

    BadArray = array:from_list(Bad),
    S1Array = array:from_list(S1),
    S2Array = array:from_list(S2),

    Lps = build_lps(BadArray),
    NextKmpStateTable = build_next_kmp_state_table(BadArray, Lps),

    ets:new(dp_table, [set, public]),

    CountS2 = count_le(N, S2Array, BadLen, NextKmpStateTable, Mod),

    ets:delete_all_objects(dp_table),

    CountS1 = count_le(N, S1Array, BadLen, NextKmpStateTable, Mod),

    IsS1Good = is_good_string(N, S1Array, BadLen, NextKmpStateTable),

    Result = (CountS2 - CountS1 + IsS1Good + Mod) rem Mod,

    ets:delete(dp_table),
    Result.

build_lps(BadArray) ->
    BadLen = array:size(BadArray),
    Lps = array:new([{size, BadLen}, {fixed, true}, {default, 0}]),
    Len = 0,
    I = 1,
    build_lps_loop(I, BadLen, Len, Lps, BadArray).

build_lps_loop(I, BadLen, Len, Lps, BadArray) ->
    if I < BadLen ->
        CharI = array:get(I, BadArray),
        CharLen = array:get(Len, BadArray),
        if CharI == CharLen ->
            NewLen = Len + 1,
            NewLps = array:set(I, NewLen, Lps),
            build_lps_loop(I + 1, BadLen, NewLen, NewLps, BadArray);
        true ->
            if Len /= 0 ->
                NewLen = array:get(Len - 1, Lps),
                build_lps_loop(I, BadLen, NewLen, Lps, BadArray);
            true ->
                NewLps = array:set(I, 0, Lps),
                build_lps_loop(I + 1, BadLen, 0, NewLps, BadArray)
            end
        end;
    true ->
        Lps
    end.

build_next_kmp_state_table(BadArray, Lps) ->
    BadLen = array:size(BadArray),
    Table = array:new([{size, BadLen + 1}]),
    build_next_kmp_state_table_kmpstate_loop(0, BadLen, Table, BadArray, Lps).

build_next_kmp_state_table_kmpstate_loop(KmpState, BadLen, Table, BadArray, Lps) ->
    if KmpState =< BadLen ->
        Row = array:new([{size, 26}, {fixed, true}, {default, 0}]),
        NewRow = build_next_kmp_state_table_charval_loop(0, KmpState, Row, BadArray, Lps, BadLen),
        NewTable = array:set(KmpState, NewRow, Table),
        build_next_kmp_state_table_kmpstate_loop(KmpState + 1, BadLen, NewTable, BadArray, Lps);
    true ->
        Table
    end.

build_next_kmp_state_table_charval_loop(CharVal, KmpState, Row, BadArray, Lps, BadLen) ->
    if CharVal =< 25 ->
        CharCode = $a + CharVal,
        EffectiveKmpState = if KmpState == BadLen ->
                                array:get(BadLen - 1, Lps);
                            true ->
                                KmpState
                            end,
        CurrentKmpState = get_next_kmp_state_calc(EffectiveKmpState, CharCode, BadArray, Lps),
        NewRow = array:set(CharVal, CurrentKmpState, Row),
        build_next_kmp_state_table_charval_loop(CharVal + 1, KmpState, NewRow, BadArray, Lps, BadLen);
    true ->
        Row
    end.

get_next_kmp_state_calc(CurrentKmpState, CharCode, BadArray, Lps) ->
    if CurrentKmpState > 0 andalso (array:get(CurrentKmpState, BadArray) /= CharCode) ->
        get_next_kmp_state_calc(array:get(CurrentKmpState - 1, Lps), CharCode, BadArray, Lps);
    true ->
        if array:get(CurrentKmpState, BadArray) == CharCode ->
            CurrentKmpState + 1;
        true ->
            CurrentKmpState
        end
    end.

get_next_kmp_state_from_table(KmpState, CharVal, NextKmpStateTable) ->
    Row = array:get(KmpState, NextKmpStateTable),
    array:get(CharVal, Row).

count_le(N, TargetSArray, BadLen, NextKmpStateTable, Mod) ->
    dp(0, 0, true, N, TargetSArray, BadLen, NextKmpStateTable, Mod).

dp(Index, KmpState, IsTight, N, TargetSArray, BadLen, NextKmpStateTable, Mod) ->
    if KmpState == BadLen ->
        0;
    Index == N ->
        1;
    true ->
        Key = {Index, KmpState, IsTight},
        case ets:lookup(dp_table, Key) of
            [{Key, Value}] -> Value;
            [] ->
                UpperLimit = if IsTight -> (array:get(Index, TargetSArray) - $a);
                             true -> 25
                             end,
                Res = dp_loop_charval(0, UpperLimit, Index, KmpState, IsTight, N, TargetSArray, BadLen, NextKmpStateTable, Mod, 0),
                ets:insert(dp_table, {Key, Res}),
                Res
        end
    end.

dp_loop_charval(CharVal, UpperLimit, Index, KmpState, IsTight, N, TargetSArray, BadLen, NextKmpStateTable, Mod, Acc) ->
    if CharVal =< UpperLimit ->
        NextKmpState = get_next_kmp_state_from_table(KmpState, CharVal, NextKmpStateTable),
        NewIsTight = IsTight andalso (CharVal == UpperLimit),
        SubRes = dp(Index + 1, NextKmpState, NewIsTight, N, TargetSArray, BadLen, NextKmpStateTable, Mod),
        NewAcc = (Acc + SubRes) rem Mod,
        dp_loop_charval(CharVal + 1, UpperLimit, Index, KmpState, IsTight, N, TargetSArray, BadLen, NextKmpStateTable, Mod, NewAcc);
    true ->
        Acc
    end.

is_good_string(N, SArray, BadLen, NextKmpStateTable) ->
    is_good_string_loop(0, N, 0, SArray, BadLen, NextKmpStateTable).

is_good_string_loop(I, N, KmpState, SArray, BadLen, NextKmpStateTable) ->
    if I < N ->
        CharVal = array:get(I, SArray) - $a,
        NewKmpState = get_next_kmp_state_from_table(KmpState, CharVal, NextKmpStateTable),
        if NewKmpState == BadLen ->
            0;
        true ->
            is_good_string_loop(I + 1, N, NewKmpState, SArray, BadLen, NextKmpStateTable)
        end;
    true ->
        1
    end.