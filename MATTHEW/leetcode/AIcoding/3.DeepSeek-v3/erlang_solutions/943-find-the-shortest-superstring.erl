-module(solution).
-export([shortest_superstring/1]).

shortest_superstring(A) ->
    N = length(A),
    if N == 0 -> "";
       true ->
        G = build_graph(A),
        {_, Path} = tsp(G, N),
        build_superstring(A, Path)
    end.

build_graph(A) ->
    N = length(A),
    G = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    lists:foldl(fun(I, AccG) ->
        lists:foldl(fun(J, AccG1) ->
            if I == J -> AccG1;
               true ->
                Overlap = calc_overlap(lists:nth(I+1, A), lists:nth(J+1, A)),
                array:set(I, array:set(J, Overlap, array:get(I, AccG1)), AccG1)
            end
        end, AccG, lists:seq(0, N-1))
    end, G, lists:seq(0, N-1)).

calc_overlap(A, B) ->
    Max = min(length(A), length(B)),
    lists:foldl(fun(L, Acc) ->
        Suffix = string:substr(A, length(A) - L + 1, L),
        Prefix = string:substr(B, 1, L),
        if Suffix == Prefix -> L;
           true -> Acc
        end
    end, 0, lists:seq(Max, 1, -1)).

tsp(G, N) ->
    DP = array:new([{size, 1 bsl N}, {default, array:new([{size, N}, {default, {0, -1}}])}]),
    lists:foreach(fun(I) ->
        DP1 = array:set(1 bsl I, array:set(I, {length(lists:nth(I+1, G)), -1}, DP), DP)
    end, lists:seq(0, N-1)),
    DP2 = lists:foldl(fun(Mask, AccDP) ->
        lists:foldl(fun(I, AccDP1) ->
            case (Mask band (1 bsl I)) /= 0 of
                false -> AccDP1;
                true ->
                    lists:foldl(fun(J, AccDP2) ->
                        case (Mask band (1 bsl J)) == 0 of
                            false -> AccDP2;
                            true ->
                                NewMask = Mask bor (1 bsl J),
                                {CurLen, _} = array:get(I, array:get(Mask, AccDP2)),
                                Overlap = array:get(J, array:get(I, G)),
                                {OldLen, _} = array:get(J, array:get(NewMask, AccDP2)),
                                if CurLen + Overlap > OldLen ->
                                    array:set(NewMask, array:set(J, {CurLen + Overlap, I}, array:get(NewMask, AccDP2)), AccDP2);
                                   true -> AccDP2
                                end
                        end
                    end, AccDP1, lists:seq(0, N-1))
            end
        end, AccDP, lists:seq(0, N-1))
    end, DP, lists:seq(1, (1 bsl N) - 1)),
    FinalMask = (1 bsl N) - 1,
    {MaxLen, Last} = lists:foldl(fun(I, {CurMax, CurLast}) ->
        {Len, _} = array:get(I, array:get(FinalMask, DP2)),
        if Len > CurMax -> {Len, I};
           true -> {CurMax, CurLast}
        end
    end, {0, -1}, lists:seq(0, N-1)),
    Path = build_path(DP2, FinalMask, Last, []),
    {MaxLen, Path}.

build_path(DP, Mask, I, Path) ->
    case I of
        -1 -> Path;
        _ ->
            {_, Prev} = array:get(I, array:get(Mask, DP)),
            build_path(DP, Mask bxor (1 bsl I), Prev, [I | Path])
    end.

build_superstring(A, [H | T]) ->
    lists:foldl(fun(I, Acc) ->
        Overlap = calc_overlap(Acc, lists:nth(I+1, A)),
        Acc ++ string:substr(lists:nth(I+1, A), Overlap + 1)
    end, lists:nth(H+1, A), T).