-module(most_frequent_ids).
-export([solve/1]).

solve(IDs) ->
    Counts = lists:foldl(fun(ID, Acc) ->
                                 case maps:find(ID, Acc) of
                                     {ok, Count} ->
                                         maps:put(ID, Count + 1, Acc);
                                     error ->
                                         maps:put(ID, 1, Acc)
                                 end
                             end, #{}, IDs),
    lists:foldl(fun({ID, Count}, Acc) ->
                        case Acc of
                            [] ->
                                [{ID, Count}];
                            [{_, MaxCount} | _] ->
                                if Count > MaxCount then
                                    [{ID, Count}]
                                else if Count == MaxCount then
                                    [{ID, Count} | Acc]
                                else
                                    Acc
                                end
                        end
                end, [], maps:to_list(Counts)).