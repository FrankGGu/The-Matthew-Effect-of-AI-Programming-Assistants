-module(solution).
-export([count_combinations/1]).

count_combinations(Pieces) ->
    {Kings, Queens, Bishops, Rooks, Knights} = parse_pieces(Pieces),
    Positions = generate_positions(),
    Combinations = find_combinations(Kings, Queens, Bishops, Rooks, Knights, Positions),
    length(Combinations).

parse_pieces(Pieces) ->
    parse_pieces(Pieces, {0, 0, 0, 0, 0}).

parse_pieces([], Acc) -> Acc;
parse_pieces([{<<"king">>, _} | Rest], {K, Q, B, R, N}) ->
    parse_pieces(Rest, {K + 1, Q, B, R, N});
parse_pieces([{<<"queen">>, _} | Rest], {K, Q, B, R, N}) ->
    parse_pieces(Rest, {K, Q + 1, B, R, N});
parse_pieces([{<<"bishop">>, _} | Rest], {K, Q, B, R, N}) ->
    parse_pieces(Rest, {K, Q, B + 1, R, N});
parse_pieces([{<<"rook">>, _} | Rest], {K, Q, B, R, N}) ->
    parse_pieces(Rest, {K, Q, B, R + 1, N});
parse_pieces([{<<"knight">>, _} | Rest], {K, Q, B, R, N}) ->
    parse_pieces(Rest, {K, Q, B, R, N + 1}).

generate_positions() ->
    [{X, Y} || X <- lists:seq(1, 8), Y <- lists:seq(1, 8)].

find_combinations(Kings, Queens, Bishops, Rooks, Knights, Positions) ->
    AllPieces = lists:duplicate(Kings, king) ++ lists:duplicate(Queens, queen) ++
                lists:duplicate(Bishops, bishop) ++ lists:duplicate(Rooks, rook) ++
                lists:duplicate(Knights, knight),
    find_combinations(AllPieces, Positions, []).

find_combinations([], _, Acc) -> [Acc];
find_combinations([Piece | Rest], Positions, Acc) ->
    lists:foldl(
        fun(Pos, CombAcc) ->
            case is_valid(Piece, Pos, Acc) of
                true -> find_combinations(Rest, Positions, [Pos | Acc]) ++ CombAcc;
                false -> CombAcc
            end
        end,
        [],
        Positions
    ).

is_valid(king, {X, Y}, Positions) ->
    not lists:any(
        fun({PX, PY}) ->
            abs(X - PX) =< 1 andalso abs(Y - PY) =< 1
        end,
        Positions
    );
is_valid(queen, {X, Y}, Positions) ->
    not lists:any(
        fun({PX, PY}) ->
            X =:= PX orelse Y =:= PY orelse abs(X - PX) =:= abs(Y - PY)
        end,
        Positions
    );
is_valid(bishop, {X, Y}, Positions) ->
    not lists:any(
        fun({PX, PY}) ->
            abs(X - PX) =:= abs(Y - PY)
        end,
        Positions
    );
is_valid(rook, {X, Y}, Positions) ->
    not lists:any(
        fun({PX, PY}) ->
            X =:= PX orelse Y =:= PY
        end,
        Positions
    );
is_valid(knight, {X, Y}, Positions) ->
    not lists:any(
        fun({PX, PY}) ->
            (abs(X - PX) =:= 2 andalso abs(Y - PY) =:= 1) orelse
            (abs(X - PX) =:= 1 andalso abs(Y - PY) =:= 2)
        end,
        Positions
    ).