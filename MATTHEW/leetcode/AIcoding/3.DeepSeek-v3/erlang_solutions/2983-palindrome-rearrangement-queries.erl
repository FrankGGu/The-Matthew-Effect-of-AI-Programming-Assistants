-module(solution).
-export([can_make_pali_queries/2]).

can_make_pali_queries(S, Queries) ->
    N = length(S),
    Prefix = lists:foldl(fun(Char, Acc) ->
        [Counts | Rest] = Acc,
        NewCounts = maps:put(Char, maps:get(Char, Counts, 0) + 1,
        [NewCounts | Acc]
    end, [#{}], S),
    PrefixCounts = lists:reverse(Prefix),
    lists:map(fun({L, R, K}) ->
        LeftCounts = maps:to_list(lists:nth(L + 1, PrefixCounts)),
        RightCounts = maps:to_list(lists:nth(R + 1, PrefixCounts)),
        OddCount = lists:foldl(fun({Char, Cnt}, Acc) ->
            Diff = maps:get(Char, maps:from_list(RightCounts), 0) - maps:get(Char, maps:from_list(LeftCounts), 0),
            case Diff rem 2 of
                1 -> Acc + 1;
                0 -> Acc
            end
        end, 0, RightCounts),
        (OddCount div 2) =< K
    end, Queries).