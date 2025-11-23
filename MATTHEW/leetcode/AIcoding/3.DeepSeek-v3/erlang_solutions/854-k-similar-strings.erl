-spec k_similarity(A :: unicode:unicode_binary(), B :: unicode:unicode_binary()) -> integer().
k_similarity(A, B) ->
    AList = binary_to_list(A),
    BList = binary_to_list(B),
    case AList == BList of
        true -> 0;
        false ->
            Queue = queue:in({AList, 0}, queue:new()),
            Seen = sets:add_element(AList, sets:new()),
            bfs(Queue, BList, Seen)
    end.

bfs(Queue, Target, Seen) ->
    {{value, {Current, Steps}}, Q} = queue:out(Queue),
    case Current == Target of
        true -> Steps;
        false ->
            {NextQueue, NextSeen} = generate_next(Current, Target, Q, Seen, Steps),
            bfs(NextQueue, Target, NextSeen)
    end.

generate_next(Current, Target, Queue, Seen, Steps) ->
    {Pos, _} = lists:splitwith(fun({X, Y}) -> X == Y end, lists:zip(Current, Target)),
    Start = length(Pos),
    generate_swaps(Current, Target, Start, Start + 1, length(Current), Queue, Seen, Steps).

generate_swaps(Current, Target, I, J, Len, Queue, Seen, Steps) when J < Len ->
    case lists:nth(I, Current) == lists:nth(J, Target) of
        true ->
            Swapped = swap(Current, I, J),
            case sets:is_element(Swapped, Seen) of
                false ->
                    NewQueue = queue:in({Swapped, Steps + 1}, Queue),
                    NewSeen = sets:add_element(Swapped, Seen),
                    generate_swaps(Current, Target, I, J + 1, Len, NewQueue, NewSeen, Steps);
                true ->
                    generate_swaps(Current, Target, I, J + 1, Len, Queue, Seen, Steps)
            end;
        false ->
            generate_swaps(Current, Target, I, J + 1, Len, Queue, Seen, Steps)
    end;
generate_swaps(Current, Target, I, J, Len, Queue, Seen, Steps) when J >= Len ->
    {Queue, Seen}.

swap(List, I, J) ->
    {Before, [Ith | Rest]} = lists:split(I - 1, List),
    {Middle, [Jth | After]} = lists:split(J - I - 1, Rest),
    Before ++ [Jth | Middle] ++ [Ith | After].