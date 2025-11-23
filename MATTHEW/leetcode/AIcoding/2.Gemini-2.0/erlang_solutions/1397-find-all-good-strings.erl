-module(find_all_good_strings).
-export([find_all_good_strings/3]).

find_all_good_strings(N, S1, S2, Evil) ->
    Len_evil = length(Evil),
    Next = build_kmp_table(Evil),
    Mod = 1000000007,
    Memo = dict:new(),
    find_all_good_strings_helper(N, S1, S2, Evil, 0, 0, 0, Next, Memo, Mod).

find_all_good_strings_helper(0, _, _, _, _, _, _, _, _, _) ->
    1;
find_all_good_strings_helper(N, S1, S2, Evil, Evil_index, Lower_bound, Upper_bound, Next, Memo, Mod) ->
    Key = {N, Evil_index, Lower_bound, Upper_bound},
    case dict:find(Key, Memo) of
        {ok, Value} ->
            Value;
        error ->
            Char_start = case Lower_bound of
                1 ->
                    hd(S1);
                0 ->
                    $a
            end,
            Char_end = case Upper_bound of
                1 ->
                    hd(S2);
                0 ->
                    $z
            end,

            Ans = lists:foldl(fun(Char, Acc) ->
                                  New_evil_index = kmp_match(Evil_index, Char, Evil, Next),

                                  case New_evil_index =:= length(Evil) of
                                      true ->
                                          Acc;
                                      false ->
                                          New_lower_bound = case Lower_bound of
                                              1 ->
                                                  case Char =:= Char_start of
                                                      true -> 1;
                                                      false -> 0
                                                  end;
                                              0 ->
                                                  0
                                          end,
                                          New_upper_bound = case Upper_bound of
                                              1 ->
                                                  case Char =:= Char_end of
                                                      true -> 1;
                                                      false -> 0
                                                  end;
                                              0 ->
                                                  0
                                          end,

                                          New_s1 = tl(S1),
                                          New_s2 = tl(S2),

                                          (Acc + find_all_good_strings_helper(N - 1, New_s1, New_s2, Evil, New_evil_index, New_lower_bound, New_upper_bound, Next, Memo, Mod)) rem Mod
                                  end
                              end,
                              0,
                              lists:seq(Char_start, Char_end)),
            dict:store(Key, Ans, Memo),
            Ans
    end.

build_kmp_table(Evil) ->
    Len = length(Evil),
    build_kmp_table_helper(Evil, 1, 0, [0], Len).

build_kmp_table_helper(Evil, I, Len, Table, Max_len) when I > Max_len ->
    lists:reverse(Table);
build_kmp_table_helper(Evil, I, Len, Table, Max_len) ->
    if
        lists:nth(I, Evil) =:= lists:nth(Len+1, Evil) ->
            build_kmp_table_helper(Evil, I+1, Len+1, [Len+1|Table], Max_len);
        Len > 0 ->
            New_len = lists:nth(Len, lists:reverse(Table)),
            build_kmp_table_helper(Evil, I, New_len, Table, Max_len);
        true ->
            build_kmp_table_helper(Evil, I+1, 0, [0|Table], Max_len)
    end.

kmp_match(Evil_index, Char, Evil, Next) ->
    kmp_match_helper(Evil_index, Char, Evil, Next, length(Evil)).

kmp_match_helper(Evil_index, Char, Evil, Next, Max_len) ->
    if
        Evil_index < Max_len andalso lists:nth(Evil_index+1, Evil) =:= Char ->
            Evil_index + 1;
        Evil_index > 0 ->
            New_evil_index = lists:nth(Evil_index, lists:reverse(Next)),
            kmp_match_helper(New_evil_index, Char, Evil, Next, Max_len);
        true ->
            0
    end.