-module(minimum_limit_of_balls_in_a_bag).
-export([reorganize_string/1]).

reorganize_string(Balls) ->
    reorganize_string(Balls, maps:from_list([{N, 1} || N <- Balls])).

reorganize_string(_, Map) when maps:size(Map) == 1 ->
    ok;
reorganize_string(Balls, Map) ->
    {MaxKey, MaxCount} = lists:last(maps:to_list(maps:filter(fun(_, V) -> V > 0 end, Map))),
    case MaxCount of
        1 ->
            ok;
        _ ->
            NewMap = maps:update(MaxKey, MaxCount - 1, Map),
            case lists:keymember(MaxKey, 1, maps:to_list(NewMap)) of
                true ->
                    reorganize_string(Balls, NewMap);
                false ->
                    ok
            end
    end.