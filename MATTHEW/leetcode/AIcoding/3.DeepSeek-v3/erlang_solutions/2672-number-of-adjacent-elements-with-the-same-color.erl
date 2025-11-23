-spec color_the_array(N :: integer(), Queries :: [[integer()]]) -> [integer()].
color_the_array(N, Queries) ->
    Initial = array:new([{size, N}, {default, 0}]),
    process_queries(Queries, Initial, 0, []).

process_queries([], _, _, Acc) ->
    lists:reverse(Acc);
process_queries([[Index, Color] | Rest], Array, Count, Acc) ->
    OldColor = array:get(Index, Array),
    NewArray = array:set(Index, Color, Array),
    NewCount = update_count(Index, OldColor, Color, Array, Count, N),
    process_queries(Rest, NewArray, NewCount, [NewCount | Acc]).

update_count(Index, OldColor, NewColor, Array, Count, N) ->
    Adjacent = get_adjacent(Index, N),
    Delta = lists:foldl(fun(AdjIndex, Acc) ->
        case array:get(AdjIndex, Array) of
            OldColor when OldColor =/= 0 -> Acc - 1;
            NewColor when NewColor =/= 0 -> Acc + 1;
            _ -> Acc
        end
    end, 0, Adjacent),
    Count + Delta.

get_adjacent(Index, N) ->
    case Index of
        0 when N > 1 -> [1];
        I when I == N - 1 -> [N - 2];
        I when I > 0, I < N - 1 -> [Index - 1, Index + 1];
        _ -> []
    end.