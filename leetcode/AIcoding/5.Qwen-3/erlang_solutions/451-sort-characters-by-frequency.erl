-module(solution).
-export([frequency_sort/1]).

frequency_sort(Str) ->
    Count = count_chars(Str),
    Sorted = lists:sort(fun({C1, N1}, {C2, N2}) ->
                            if
                                N1 > N2 -> true;
                                N1 == N2 -> C1 < C2;
                                true -> false
                            end
                        end, Count),
    lists:flatten([lists:duplicate(N, C) || {C, N} <- Sorted]).

count_chars(Str) ->
    count_chars(Str, #{}).

count_chars([], Acc) ->
    maps:to_list(Acc);
count_chars([H | T], Acc) ->
    NewAcc = case maps:is_key(H, Acc) of
                 true -> maps:update(H, maps:get(H, Acc) + 1, Acc);
                 false -> maps:put(H, 1, Acc)
             end,
    count_chars(T, NewAcc).