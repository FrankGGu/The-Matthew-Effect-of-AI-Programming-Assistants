-module(solution).
-export([numberOfWeeks/1]).

numberOfWeeks(Blocks) ->
    lists:foldl(fun(A, {Acc, Max}) ->
                       if
                           A > Max -> {A + Acc, A};
                           true -> {Acc + A, Max}
                       end
                   end, {0, 0}, Blocks)
    || {Total, _} <- [lists:foldl(fun(A, {Acc, Max}) ->
                                         if
                                             A > Max -> {A + Acc, A};
                                             true -> {Acc + A, Max}
                                         end
                                     end, {0, 0}, Blocks)],
       Total.