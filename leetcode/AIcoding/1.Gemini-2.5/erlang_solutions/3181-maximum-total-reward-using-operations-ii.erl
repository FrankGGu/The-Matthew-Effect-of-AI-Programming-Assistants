-module(solution).
-export([maximum_total_reward/1]).

maximum_total_reward(Reward) ->
    SortedReward = lists:sort(Reward),
    MaxRewardVal = lists:max(Reward),
    MaxPossibleSum = 2 * MaxRewardVal - 1,
    DpSize = MaxPossibleSum + 1,

    Dp = array:set(0, true, array:new(DpSize, false)),

    FinalDp = lists:foldl(fun(R, CurrentDp) ->
                              TempDp = array:new(DpSize, false),

                              MaxCurrentSum = find_max_index(CurrentDp, DpSize - 1),

                              NewTempDp = lists:foldl(fun(S, AccTempDp) ->
                                                          case array:get(S, CurrentDp) of
                                                              true when R > S ->
                                                                  array:set(S + R, true, AccTempDp);
                                                              _ ->
                                                                  AccTempDp
                                                          end
                                                      end, TempDp, lists:seq(0, MaxCurrentSum)),

                              UpdatedDp = array:new(DpSize, false),
                              lists:foldl(fun(Idx, AccDp) ->
                                              case array:get(Idx, CurrentDp) orelse array:get(Idx, NewTempDp) of
                                                  true -> array:set(Idx, true, AccDp);
                                                  false -> AccDp
                                              end
                                          end, UpdatedDp, lists:seq(0, DpSize - 1))
                          end, Dp, SortedReward),

    find_max_index(FinalDp, DpSize - 1).

find_max_index(Arr, MaxIdx) ->
    find_max_index_loop(Arr, MaxIdx).

find_max_index_loop(Arr, Idx) when Idx >= 0 ->
    case array:get(Idx, Arr) of
        true -> Idx;
        false -> find_max_index_loop(Arr, Idx - 1)
    end;
find_max_index_loop(_Arr, _Idx) ->
    0.