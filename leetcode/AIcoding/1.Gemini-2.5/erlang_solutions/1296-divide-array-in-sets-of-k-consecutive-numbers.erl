-module(solution).
-export([is_possible_divide/2]).

is_possible_divide(Hand, K) when length(Hand) rem K =/= 0 ->
    false;
is_possible_divide(Hand, K) ->
    FreqMap = count_frequencies(Hand),
    SortedUniqueNumbers = lists:sort(maps:keys(FreqMap)),
    check_sets(SortedUniqueNumbers, FreqMap, K).

count_frequencies(List) ->
    lists:foldl(fun(X, Acc) ->
                            maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                    end, maps:new(), List).

check_sets([], _FreqMap, _K) ->
    true;
check_sets([N|Rest], FreqMap, K) ->
    case maps:get(N, FreqMap, 0) of
        0 ->
            check_sets(Rest, FreqMap, K);
        CountN ->
            case try_form_sets(N, CountN, K, FreqMap) of
                {ok, UpdatedMap} ->
                    check_sets(Rest, UpdatedMap, K);
                {error, _Reason} ->
                    false
            end
    end.

try_form_sets(StartN, NumSets, K, FreqMap) ->
    lists:foldl(fun(I, Acc) ->
                        case Acc of
                            {ok, CurrentMap} ->
                                CurrentNum = StartN + I,
                                case maps:get(CurrentNum, CurrentMap, 0) of
                                    Val when Val >= NumSets ->
                                        {ok, maps:update(CurrentNum, Val - NumSets, CurrentMap)};
                                    _ ->
                                        {error, "Not enough consecutive numbers"}
                                end;
                            _ -> Acc
                        end
                end, {ok, FreqMap}, lists:seq(0, K - 1)).