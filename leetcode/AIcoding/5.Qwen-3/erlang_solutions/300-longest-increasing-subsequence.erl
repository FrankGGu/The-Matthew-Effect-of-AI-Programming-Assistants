-module(longest_increasing_subsequence).
-export([length_of_lis/1]).

length_of_lis([]) -> 0;
length_of_lis([H|T]) ->
    lists:foldl(fun(X, Acc) ->
                        if X > H -> max(Acc + 1, length_of_lis([X|T]));
                           true -> Acc
                        end
                end, 1, T).

length_of_lis(_, _, []) -> 0;
length_of_lis(Nums, StartIndex, [H|T]) ->
    case H > lists:nth(StartIndex, Nums) of
        true ->
            max(1 + length_of_lis([H|T], StartIndex + 1, T), length_of_lis(Nums, StartIndex + 1, T));
        false ->
            length_of_lis(Nums, StartIndex + 1, T)
    end.

length_of_lis(Nums) ->
    lists:foldl(fun(I, Acc) ->
                        max(Acc, length_of_lis(Nums, I, Nums))
                end, 0, lists:seq(0, length(Nums) - 1)).