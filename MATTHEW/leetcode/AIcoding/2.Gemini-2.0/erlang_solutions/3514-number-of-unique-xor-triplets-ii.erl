-module(unique_xor_triplets_ii).
-export([number_of_unique_xor_triplets/1]).

number_of_unique_xor_triplets(Nums) ->
    number_of_unique_xor_triplets(Nums, 0, 0, 0, sets:new()).

number_of_unique_xor_triplets([], _, _, Count, _) ->
    Count;
number_of_unique_xor_triplets([A | Rest], I, J, K, Seen) ->
    NewSeen =
        lists:foldl(
            fun(B, AccSeen) ->
                lists:foldl(
                    fun(C, AccSeenInner) ->
                        XorResult = A bxor B bxor C,
                        SortedTriplet = lists:sort([A, B, C]),
                        TripletTuple = list_to_tuple(SortedTriplet),
                        case sets:is_element(TripletTuple, AccSeenInner) of
                            true ->
                                AccSeenInner;
                            false ->
                                sets:add_element(TripletTuple, AccSeenInner)
                        end
                    end,
                    AccSeen,
                    lists:nthtail(J+1, Rest)
                )
            end,
            Seen,
            lists:nthtail(I+1, Rest)
        ),
    NewCount = sets:size(NewSeen) - sets:size(Seen),

    number_of_unique_xor_triplets(Rest, I+1, J, K, NewSeen) + NewCount.