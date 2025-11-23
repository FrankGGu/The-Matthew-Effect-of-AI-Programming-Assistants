-module(solution).
-export([can_remove_one/1]).

can_remove_one(Array) ->
    can_remove_one(Array, 0).

can_remove_one(Array, Removed) ->
    case lists:foldl(fun(X, {Last, Acc}) ->
                          if
                              Acc > 1 -> {Last, Acc};
                              X > Last -> {X, Acc};
                              Removed =:= 0 -> {X, Acc + 1};
                              true -> {Last, Acc + 1}
                          end
                      end, {hd(Array), 0}, tl(Array)) of
        {_, Acc} -> Acc =< 1
    end.