-module(split_array).
-export([is_possible/1]).

is_possible(Nums) ->
    is_possible(Nums, #{}, #{}).

is_possible([], _, _) ->
    true;
is_possible([H|T], Ends, Freq) ->
    case maps:get(H, Freq, 0) of
        0 ->
            is_possible(T, Ends, Freq);
        _ ->
            case maps:get(H - 1, Ends, 0) of
                0 ->
                    case lists:member(H + 1, T) andalso lists:member(H + 2, T) of
                        true ->
                            Freq1 = maps:update_with(H, fun(V) -> V - 1 end, 0, Freq),
                            Freq2 = maps:update_with(H + 1, fun(V) -> V - 1 end, 0, Freq1),
                            Freq3 = maps:update_with(H + 2, fun(V) -> V - 1 end, 0, Freq2),
                            Ends2 = maps:update_with(H + 2, fun(V) -> V + 1 end, 1, Ends),
                            is_possible(T, Ends2, Freq3);
                        false ->
                            false
                    end;
                _ ->
                    Freq1 = maps:update_with(H, fun(V) -> V - 1 end, 0, Freq),
                    Ends1 = maps:update_with(H - 1, fun(V) -> V - 1 end, 0, Ends),
                    Ends2 = maps:update_with(H, fun(V) -> V + 1 end, 1, Ends1),
                    is_possible(T, Ends2, Freq1)
            end
    end.