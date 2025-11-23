-module(min_steps).
-export([min_steps/2]).

min_steps(S, T) ->
    Steps = 0,
    S_map = string_to_map(S),
    T_map = string_to_map(T),

    Steps1 = lists:foldl(fun(Key, Acc) ->
                               case maps:find(Key, T_map) of
                                   {ok, Count} ->
                                       S_count = maps:get(Key, S_map);
                                       Acc + max(0, S_count - Count);
                                   error ->
                                       S_count = maps:get(Key, S_map);
                                       Acc + S_count
                               end
                           end, 0, maps:keys(S_map)),

    Steps2 = lists:foldl(fun(Key, Acc) ->
                               case maps:find(Key, S_map) of
                                   {ok, _} ->
                                       Acc;
                                   error ->
                                       T_count = maps:get(Key, T_map);
                                       Acc + T_count
                               end
                           end, 0, maps:keys(T_map)),
    Steps1 + Steps2.

string_to_map(Str) ->
    string:foldl(fun(Char, Acc) ->
                         case maps:find(Char, Acc) of
                             {ok, Count} ->
                                 maps:put(Char, Count + 1, Acc);
                             error ->
                                 maps:put(Char, 1, Acc)
                         end
                     end, #{}, Str).