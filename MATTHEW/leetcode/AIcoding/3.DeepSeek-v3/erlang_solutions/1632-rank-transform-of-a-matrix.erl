-module(solution).
-export([matrix_rank_transform/1]).

matrix_rank_transform(Matrix) ->
    case Matrix of
        [] -> [];
        _ ->
            M = length(Matrix),
            N = length(hd(Matrix)),
            Coords = lists:flatten([ [{I, J} || J <- lists:seq(0, N-1)] || I <- lists:seq(0, M-1)]),
            Sorted = lists:sort(fun({I1, J1}, {I2, J2}) -> 
                V1 = lists:nth(J1+1, lists:nth(I1+1, Matrix)),
                V2 = lists:nth(J2+1, lists:nth(I2+1, Matrix)),
                V1 =< V2
            end, Coords),
            Rank = maps:new(),
            DSU = lists:foldl(fun({I, J}, Acc) -> 
                maps:put({I, J}, {I, J}, Acc)
            end, maps:new(), Coords),
            process_sorted(Sorted, Matrix, Rank, DSU, M, N)
    end.

process_sorted([], _, Rank, _, _, _) -> Rank;
process_sorted([{I, J} | Rest], Matrix, Rank, DSU, M, N) ->
    Value = lists:nth(J+1, lists:nth(I+1, Matrix)),
    Groups = find_groups(I, J, Matrix, DSU, M, N, Value),
    MaxRank = get_max_rank(Groups, Rank),
    NewRank = update_rank(Groups, MaxRank + 1, Rank),
    NewDSU = update_dsu(Groups, DSU),
    process_sorted(Rest, Matrix, NewRank, NewDSU, M, N).

find_groups(I, J, Matrix, DSU, M, N, Value) ->
    Row = [ {I, K} || K <- lists:seq(0, N-1), lists:nth(K+1, lists:nth(I+1, Matrix)) == Value ],
    Col = [ {K, J} || K <- lists:seq(0, M-1), lists:nth(J+1, lists:nth(K+1, Matrix)) == Value ],
    All = lists:usort(Row ++ Col),
    [ find_root(Coord, DSU) || Coord <- All ].

find_root(Coord, DSU) ->
    Parent = maps:get(Coord, DSU),
    case Parent of
        Coord -> Coord;
        _ ->
            Root = find_root(Parent, DSU),
            DSU1 = maps:put(Coord, Root, DSU),
            Root
    end.

get_max_rank(Groups, Rank) ->
    lists:foldl(fun(Group, Max) ->
        case maps:find(Group, Rank) of
            {ok, R} -> max(Max, R);
            error -> Max
        end
    end, -1, Groups).

update_rank(Groups, NewRank, Rank) ->
    lists:foldl(fun(Group, Acc) ->
        maps:put(Group, NewRank, Acc)
    end, Rank, Groups).

update_dsu(Groups, DSU) ->
    case Groups of
        [] -> DSU;
        [First | Rest] ->
            lists:foldl(fun(Group, Acc) ->
                maps:put(Group, First, Acc)
            end, DSU, Rest)
    end.

build_result(Matrix, Rank, M, N) ->
    [ [ maps:get(find_root({I, J}, Rank), Rank) || J <- lists:seq(0, N-1) ] || I <- lists:seq(0, M-1) ].