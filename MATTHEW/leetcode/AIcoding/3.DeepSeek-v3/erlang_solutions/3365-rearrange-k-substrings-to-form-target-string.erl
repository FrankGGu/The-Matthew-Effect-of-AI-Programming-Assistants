-module(solution).
-export([can_construct/3]).

can_construct(S, K, Target) ->
    SCount = count_chars(S),
    TargetCount = count_chars(Target),
    case check_counts(SCount, TargetCount, K) of
        true -> true;
        false -> false
    end.

count_chars(Str) ->
    count_chars(Str, #{}).

count_chars([], CountMap) ->
    CountMap;
count_chars([Char | Rest], CountMap) ->
    NewCountMap = maps:update_with(Char, fun(V) -> V + 1 end, 1, CountMap),
    count_chars(Rest, NewCountMap).

check_counts(SCount, TargetCount, K) ->
    maps:fold(
        fun(Char, TargetCnt, Acc) ->
            case maps:get(Char, SCount, 0) of
                SCnt when SCnt >= TargetCnt ->
                    Acc andalso (SCnt div TargetCnt >= 1) andalso (SCnt =< TargetCnt * K);
                _ ->
                    false
            end
        end,
        true,
        TargetCount
    ).