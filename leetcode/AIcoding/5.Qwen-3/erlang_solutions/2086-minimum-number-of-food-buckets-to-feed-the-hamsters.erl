-module(min_food_buckets).
-export([feed_hamsters/1]).

feed_hamsters(Hamsters) ->
    feed_hamsters(Hamsters, 0, 0).

feed_hameters([], _, Count) ->
    Count;
feed_hamsters([$H | Rest], Index, Count) ->
    case Index of
        0 ->
            if
                length(Rest) >= 1 andalso lists:nth(1, Rest) == $F ->
                    feed_hamsters(Rest, Index + 1, Count + 1);
                true ->
                    feed_hamsters(Rest, Index + 1, Count)
            end;
        _ ->
            if
                Index == length(Hamsters) - 1 ->
                    if
                        lists:nth(Index, Hamsters) == $H ->
                            feed_hamsters(Rest, Index + 1, Count + 1);
                        true ->
                            feed_hamsters(Rest, Index + 1, Count)
                    end;
                true ->
                    if
                        lists:nth(Index + 1, Hamsters) == $F ->
                            feed_hamsters(Rest, Index + 2, Count + 1);
                        true ->
                            feed_hamsters(Rest, Index + 1, Count)
                    end
            end
    end.