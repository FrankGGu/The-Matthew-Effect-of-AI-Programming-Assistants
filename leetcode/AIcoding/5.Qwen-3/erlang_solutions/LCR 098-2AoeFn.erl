-module(unique_paths).
-export([unique_paths/2]).

unique_paths(M, N) ->
    unique_paths(M, N, 1, 1).

unique_paths(M, N, Row, Col) when Row == M, Col == N ->
    1;
unique_paths(M, N, Row, Col) when Row == M ->
    unique_paths(M, N, Row, Col + 1);
unique_paths(M, N, Row, Col) when Col == N ->
    unique_paths(M, N, Row + 1, Col);
unique_paths(M, N, Row, Col) ->
    unique_paths(M, N, Row + 1, Col) + unique_paths(M, N, Row, Col + 1).