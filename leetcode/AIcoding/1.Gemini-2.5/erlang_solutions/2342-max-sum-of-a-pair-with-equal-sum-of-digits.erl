-module(solution).
-export([maximumSum/1]).

-spec maximumSum(Nums :: [integer()]) -> integer().
maximumSum(Nums) ->
    Grouped = lists:foldl(fun(Num, Acc) ->
                                  SD = sum_digits(Num),
                                  maps:update_with(SD, fun(List) -> [Num | List] end, [Num], Acc)
                          end, #{}, Nums),

    MaxSum = maps:fold(fun(_SD, List, CurrentMax) ->
                               case length(List) of
                                   L when L >= 2 ->
                                       {N1, N2} = find_top_two(List),
                                       max(CurrentMax, N1 + N2);
                                   _ ->
                                       CurrentMax
                               end
                       end, -1, Grouped),
    MaxSum.

sum_digits(0) -> 0;
sum_digits(N) when N > 0 ->
    (N rem 10) + sum_digits(N div 10).

find_top_two([A, B]) when A >= B -> {A, B};
find_top_two([A, B]) -> {B, A};
find_top_two([H|T]) ->
    find_top_two_recursive(T, H, -1).

find_top_two_recursive([], L1, L2) -> {L1, L2};
find_top_two_recursive([X|Xs], L1, L2) when X > L1 ->
    find_top_two_recursive(Xs, X, L1);
find_top_two_recursive([X|Xs], L1, L2) when X > L2 ->
    find_top_two_recursive(Xs, L1, X);
find_top_two_recursive([_X|Xs], L1, L2) ->
    find_top_two_recursive(Xs, L1, L2).