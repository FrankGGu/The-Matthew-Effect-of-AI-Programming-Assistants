-module(range_freq_queries).

-export([init/1, query/4]).

-record(state, {nums, index_map}).

init(Nums) ->
    IndexMap = build_index_map(Nums, 0, #{}),
    #state{nums = Nums, index_map = IndexMap}.

query(State, Left, Right, Value) ->
    #state{nums = Nums, index_map = IndexMap} = State,
    case maps:get(Value, IndexMap, []) of
        [] -> 0;
        Indices ->
            L = find_ge(Indices, Left),
            R = find_le(Indices, Right),
            if
                L =:= -1; R =:= -1; L > R -> 0;
                true -> R - L + 1
            end
    end.

build_index_map([], _, Map) -> Map;
build_index_map([Num | Rest], Index, Map) ->
    NewMap = maps:update_with(Num, fun(Indices) -> Indices ++ [Index] end, [Index], Map),
    build_index_map(Rest, Index + 1, NewMap).

find_ge(Indices, Target) ->
    find_ge(Indices, Target, 0, length(Indices) - 1).

find_ge(Indices, Target, Low, High) ->
    if
        Low > High -> -1;
        true ->
            Mid = (Low + High) div 2,
            case lists:nth(Mid + 1, Indices) of
                Val when Val >= Target ->
                    case Mid =:= 0 of
                        true -> Mid;
                        false ->
                            case lists:nth(Mid, Indices) of
                                Prev when Prev < Target -> Mid;
                                _ -> find_ge(Indices, Target, Low, Mid - 1)
                            end
                    end;
                _ -> find_ge(Indices, Target, Mid + 1, High)
            end
    end.

find_le(Indices, Target) ->
    find_le(Indices, Target, 0, length(Indices) - 1).

find_le(Indices, Target, Low, High) ->
    if
        Low > High -> -1;
        true ->
            Mid = (Low + High) div 2,
            case lists:nth(Mid + 1, Indices) of
                Val when Val =< Target ->
                    case Mid =:= length(Indices) - 1 of
                        true -> Mid;
                        false ->
                            case lists:nth(Mid + 2, Indices) of
                                Next when Next > Target -> Mid;
                                _ -> find_le(Indices, Target, Mid + 1, High)
                            end
                    end;
                _ -> find_le(Indices, Target, Low, Mid - 1)
            end
    end.