-module(max_width_ramp).
-export([main/1]).

main(Numbers) ->
    max_width_ramp(Numbers).

max_width_ramp(Numbers) ->
    Len = length(Numbers),
    if
        Len < 2 -> 0;
        true ->
            Sorted = lists:sort([{N, I} || {N, I} <- lists:zip(Numbers, lists:seq(0, Len - 1))]),
            MaxWidth = 0,
            MinIndex = maps:new(),
            lists:foldl(fun({N, I}, {MaxW, MinIdx}) ->
                            case maps:is_key(N, MinIdx) of
                                true -> {MaxW, MinIdx};
                                false -> {max(MaxW, I - maps:get(N, MinIdx)), maps:put(N, I, MinIdx)}
                            end
                        end, {MaxWidth, MinIndex}, Sorted)
    end.