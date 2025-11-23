-module(rotate_image).
-export([rotate/1]).

rotate(Matrix) ->
    N = length(Matrix),
    rotate(Matrix, N, 0).

rotate(_, _, N) when N >= N -> Matrix;
rotate(Matrix, N, I) ->
    rotate(Matrix, N, I + 1, 0).

rotate(_, _, _, N) when N >= N -> Matrix;
rotate(Matrix, N, I, J) ->
    Temp = lists:nth(J+1, lists:nth(I+1, Matrix)),
    lists:setelement(J+1, lists:nth(I+1, Matrix), lists:nth(I+1, lists:nth(N-J-1, Matrix))),
    lists:setelement(N-J-1, lists:nth(I+1, Matrix), lists:nth(N-I-1, lists:nth(N-J-1, Matrix))),
    lists:setelement(N-I-1, lists:nth(I+1, Matrix), lists:nth(N-I-1, lists:nth(J+1, Matrix))),
    lists:setelement(J+1, lists:nth(I+1, Matrix), Temp),
    rotate(Matrix, N, I, J + 1).