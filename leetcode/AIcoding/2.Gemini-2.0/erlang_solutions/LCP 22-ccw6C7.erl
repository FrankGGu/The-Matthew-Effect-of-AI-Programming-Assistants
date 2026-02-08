-module(black_white_box).
-export([paintingPlan/3]).

paintingPlan(M, N, K) ->
    lists:sum([
        case count_ways(M, N, K, Row, Col) of
            0 -> 0;
            W -> 1
        end
     || Row <- lists:seq(0, M), Col <- lists:seq(0, N)]).

count_ways(M, N, K, Row, Col) ->
    count_rows(M, N, K, Row) * count_cols(M, N, K, Col).

count_rows(M, N, K, Row) ->
    case K - Row >= 0 of
        true -> comb(M, Row) * count_cols_helper(N, K - Row);
        false -> 0
    end.

count_cols(M, N, K, Col) ->
    case K - Col >= 0 of
        true -> comb(N, Col) * count_rows_helper(M, K - Col);
        false -> 0
    end.

count_cols_helper(N, K) ->
    lists:sum([comb(N, I) || I <- lists:seq(0, N), I =:= K]).

count_rows_helper(M, K) ->
    lists:sum([comb(M, I) || I <- lists:seq(0, M), I =:= K]).

comb(N, K) ->
    fact(N) div (fact(K) * fact(N - K)).

fact(0) -> 1;
fact(N) -> N * fact(N - 1).