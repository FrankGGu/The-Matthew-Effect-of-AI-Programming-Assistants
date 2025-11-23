-spec min_k_bit_flips(Nums :: [integer()], K :: integer()) -> integer().
min_k_bit_flips(Nums, K) ->
    min_k_bit_flips(Nums, K, 0, 0, []).

min_k_bit_flips([], _, _, Flips, _) ->
    Flips;
min_k_bit_flips([H | T], K, I, Flips, Queue) ->
    case {H, length(Queue) rem 2} of
        {0, 0} ->
            NewFlips = Flips + 1,
            NewQueue = enqueue(Queue, I + K - 1),
            min_k_bit_flips(T, K, I + 1, NewFlips, NewQueue);
        {1, 1} ->
            NewFlips = Flips + 1,
            NewQueue = enqueue(Queue, I + K - 1),
            min_k_bit_flips(T, K, I + 1, NewFlips, NewQueue);
        _ ->
            NewQueue = case Queue of
                [Q | Rest] when Q =:= I -> Rest;
                _ -> Queue
            end,
            min_k_bit_flips(T, K, I + 1, Flips, NewQueue)
    end.

enqueue(Queue, X) ->
    lists:merge(Queue, [X]).