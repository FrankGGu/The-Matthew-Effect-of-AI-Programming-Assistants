-module(earliest_second).
-export([earliest_second_to_mark_indices/3]).

earliest_second_to_mark_indices(Nums, ChangeIndices, K) ->
    case can_mark(Nums, ChangeIndices, K, 1, length(ChangeIndices)) of
        {ok, Ans} -> Ans;
        _ -> -1
    end.

can_mark(Nums, ChangeIndices, K, Low, High) ->
    if
        Low > High -> error;
        true ->
            Mid = (Low + High) div 2,
            case is_possible(Nums, ChangeIndices, K, Mid) of
                true ->
                    case can_mark(Nums, ChangeIndices, K, Low, Mid - 1) of
                        {ok, Ans} -> {ok, Ans};
                        _ -> {ok, Mid}
                    end;
                false ->
                    can_mark(Nums, ChangeIndices, K, Mid + 1, High)
            end
    end.

is_possible(Nums, ChangeIndices, K, S) ->
    LastUsed = maps:new(),
    Required = lists:seq(1, length(Nums)),
    lists:foldl(fun(Idx, {Possible, Used, Sum}) ->
                    case Possible of
                        false -> {false, Used, Sum};
                        true ->
                            case lists:member(Idx, Required) andalso not maps:is_key(Idx, Used) of
                                true ->
                                    case Sum + lists:nth(Idx, Nums) + 1 =< S of
                                        true ->
                                            NewUsed = maps:put(Idx, true, Used),
                                            NewSum = Sum + lists:nth(Idx, Nums) + 1,
                                            {true, NewUsed, NewSum};
                                        false ->
                                            {false, Used, Sum}
                                    end;
                                false ->
                                    {Possible, Used, Sum}
                            end
                    end
                end, {true, maps:new(), 0}, lists:sublist(ChangeIndices, S)).