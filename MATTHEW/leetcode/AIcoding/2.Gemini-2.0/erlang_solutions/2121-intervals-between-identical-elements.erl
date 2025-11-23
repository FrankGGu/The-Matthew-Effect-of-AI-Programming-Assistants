-module(intervals_between_identical_elements).
-export([get_distances/1]).

get_distances(Arr) ->
  Map = lists:foldl(fun(Elem, Acc) ->
                       case maps:is_key(Elem, Acc) of
                         true ->
                           maps:update(Elem, [length(maps:get(Elem, Acc)) | maps:get(Elem, Acc)], Acc);
                         false ->
                           maps:put(Elem, [0], Acc)
                       end
                     end, #{}, lists:zip(Arr, lists:seq(0, length(Arr) - 1))),

  lists:map(fun({_Val, Index}) ->
              Key = lists:nth(Index + 1, Arr),
              Indices = maps:get(Key, Map),
              lists:foldl(fun(I, Acc) ->
                            Acc + abs(I - Index)
                          end, 0, Indices)
            end, lists:zip(Arr, lists:seq(0, length(Arr) - 1))).