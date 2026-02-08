-module(solution).
-export([main/0]).

main() ->
    Input = [3,10,5,25,2,8],
    io:format("~p~n", [max_xor(Input)]).

max_xor(Nums) ->
    Max = 0,
    lists:foldl(fun(N, Acc) ->
        lists:foldl(fun(M, Acc2) ->
            if N /= M -> max(Acc2, N bxor M);
               true -> Acc2
            end
        end, Acc, Nums)
    end, Max, Nums).

max(A, B) when A > B -> A;
max(_, B) -> B.