-module(make_equal).
-export([solve/1]).

solve([S, T]) ->
    solve(string:to_list(S), string:to_list(T)).

solve(S, T) ->
    solve(S, T, maps:new(), maps:new()).

solve([], [], _, _) ->
    false;
solve(S, T, S_freq, T_freq) ->
    S_chars = lists:usort(S),
    T_chars = lists:usort(T),

    S_freq_final = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), S),
    T_freq_final = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), T),

    S_distinct = maps:size(S_freq_final),
    T_distinct = maps:size(T_freq_final),

    lists:any(fun(S_char) ->
        lists:any(fun(T_char) ->
            New_S_freq = maps:update_with(S_char, fun(V) -> V - 1 end, 0, S_freq_final),
            New_S_freq2 = case maps:get(S_char, New_S_freq, -1) of
                            0 -> maps:remove(S_char, New_S_freq);
                            _ -> New_S_freq
                        end,

            New_T_freq = maps:update_with(T_char, fun(V) -> V - 1 end, 0, T_freq_final),
            New_T_freq2 = case maps:get(T_char, New_T_freq, -1) of
                            0 -> maps:remove(T_char, New_T_freq);
                            _ -> New_T_freq
                        end,

            New_S_freq3 = maps:update_with(T_char, fun(V) -> V + 1 end, 1, New_S_freq2),
            New_T_freq3 = maps:update_with(S_char, fun(V) -> V + 1 end, 1, New_T_freq2),

            maps:size(New_S_freq3) == T_distinct andalso maps:size(New_T_freq3) == S_distinct
        end, T_chars)
    end, S_chars).