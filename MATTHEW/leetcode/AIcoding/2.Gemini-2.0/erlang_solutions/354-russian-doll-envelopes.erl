-module(russian_doll_envelopes).
-export([max_envelopes/1]).

max_envelopes(Envelopes) ->
    SortedEnvelopes = lists:sort(fun({W1, H1}, {W2, H2}) ->
                                         if W1 < W2 ->
                                             true;
                                         W1 > W2 ->
                                             false;
                                         true ->
                                             H1 > H2
                                         end
                                 end, Envelopes),
    Heights = [H || {_, H} <- SortedEnvelopes],
    Tails = [],
    lists:foldl(fun(Height, Acc) ->
                        UpdateTails(Height, Acc)
                end, Tails, Heights).

UpdateTails(Height, Tails) ->
    case find_first_greater(Height, Tails) of
        none ->
            Tails ++ [Height];
        {index, Index} ->
            lists:substitute(Index, lists:nth(Index, Tails), Height, Tails)
    end.

find_first_greater(Height, Tails) ->
    find_first_greater_helper(Height, Tails, 1).

find_first_greater_helper(Height, [], _) ->
    none;
find_first_greater_helper(Height, [H | Rest], Index) ->
    if H >= Height ->
        {index, Index};
    true ->
        find_first_greater_helper(Height, Rest, Index + 1)
    end.