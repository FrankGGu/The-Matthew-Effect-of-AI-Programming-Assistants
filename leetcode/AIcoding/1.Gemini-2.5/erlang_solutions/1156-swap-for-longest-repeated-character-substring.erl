-module(solution).
-export([max_repeated_character_substring/1]).

max_repeated_character_substring(String) ->
    case String of
        [] -> 0;
        _ ->
            CharList = string:to_list(String),
            Counts = char_counts(CharList),
            Grouped = group_chars(CharList),

            MaxLen1 = lists:foldl(fun({Char, Len}, AccMax) ->
                                          TotalCount = maps:get(Char, Counts, 0),
                                          CurrentMax = max(AccMax, Len),
                                          if TotalCount > Len ->
                                                 max(CurrentMax, Len + 1);
                                             true ->
                                                 CurrentMax
                                          end
                                  end, 0, Grouped),

            MaxLen2 = calculate_max_len_connecting(Grouped, Counts, MaxLen1),

            MaxLen2
    end.

char_counts(S) ->
    lists:foldl(fun(Char, Map) ->
                        maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Map)
                end, maps:new(), S).

group_chars(S) ->
    group_chars(S, []).

group_chars([], Acc) ->
    lists:reverse(Acc);
group_chars([H|T], []) ->
    group_chars(T, [{H, 1}]);
group_chars([H|T], [{H, Count}|AccT]) ->
    group_chars(T, [{H, Count + 1}|AccT]);
group_chars([H|T], Acc) ->
    group_chars(T, [{H, 1}|Acc]).

calculate_max_len_connecting([], _Counts, AccMax) -> AccMax;
calculate_max_len_connecting([_], _Counts, AccMax) -> AccMax;
calculate_max_len_connecting([_, _], _Counts, AccMax) -> AccMax;
calculate_max_len_connecting([{Char1, Len1}, {OtherChar, 1}, {Char3, Len3}|Rest], Counts, AccMax) when Char1 == Char3, Char1 /= OtherChar ->
    TotalCount = maps:get(Char1, Counts, 0),
    CandidateLen = Len1 + Len3,
    NewAccMax = if TotalCount > CandidateLen ->
                       max(AccMax, CandidateLen + 1);
                   true ->
                       max(AccMax, CandidateLen)
                end,
    calculate_max_len_connecting([{OtherChar, 1}, {Char3, Len3}|Rest], Counts, NewAccMax);
calculate_max_len_connecting([_H|T], Counts, AccMax) ->
    calculate_max_len_connecting(T, Counts, AccMax).