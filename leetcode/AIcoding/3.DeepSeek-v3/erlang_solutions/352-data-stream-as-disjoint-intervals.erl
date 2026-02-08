-module(summary_ranges).
-export([init/0, add_num/1, get_intervals/1]).

-record(state, {nums = sets:new()}).

init() ->
    #state{}.

add_num(Value, State = #state{nums = Nums}) ->
    State#state{nums = sets:add_element(Value, Nums)}.

get_intervals(State = #state{nums = Nums}) ->
    case sets:size(Nums) of
        0 -> [];
        _ ->
            Sorted = lists:sort(sets:to_list(Nums)),
            merge(Sorted)
    end.

merge([H | T]) ->
    merge(T, H, H, []).

merge([], Start, End, Acc) ->
    lists:reverse([[Start, End] | Acc]);
merge([H | T], Start, End, Acc) when H =:= End + 1 ->
    merge(T, Start, H, Acc);
merge([H | T], Start, End, Acc) ->
    merge(T, H, H, [[Start, End] | Acc]).