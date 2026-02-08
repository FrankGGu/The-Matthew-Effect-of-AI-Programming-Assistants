-module(pizza_cuts).
-export([num_ways/3]).

num_ways(Rows, Cols, K) ->
    Pizza = get_pizza(Rows, Cols),
    DP = array:new([Rows+1, Cols+1], {fixed, 0}),
    prefix_sum(Pizza, DP, Rows, Cols),
    memo(DP, 0, 0, K, Rows, Cols).

get_pizza(Rows, Cols) ->
    lists:map(fun(_) -> io:get_line("") end, lists:seq(1, Rows)).

prefix_sum(Pizza, DP, Rows, Cols) ->
    prefix_sum_helper(Pizza, DP, Rows, Cols, Rows, Cols).

prefix_sum_helper(_Pizza, DP, _Rows, _Cols, 0, _C) ->
    array:set({0, 0}, 0, DP);
prefix_sum_helper(_Pizza, DP, _Rows, Cols, 0, C) ->
    array:set({0, C}, 0, DP),
    prefix_sum_helper(_Pizza, DP, _Rows, Cols, 0, C-1);
prefix_sum_helper(_Pizza, DP, Rows, _Cols, R, 0) ->
    array:set({R, 0}, 0, DP),
    prefix_sum_helper(_Pizza, DP, Rows, _Cols, R-1, 0);
prefix_sum_helper(Pizza, DP, Rows, Cols, R, C) ->
    Val = (if lists:nth(C, string:tokens(lists:nth(R+1, Pizza), "\n")) == "$" -> 1; true -> 0 end)
          + array:get({R-1, C}, DP)
          + array:get({R, C-1}, DP)
          - array:get({R-1, C-1}, DP),
    array:set({R, C}, Val, DP),
    prefix_sum_helper(Pizza, DP, Rows, Cols, R, C-1),
    prefix_sum_helper(Pizza, DP, Rows, Cols, R-1, Cols),
    prefix_sum_helper(Pizza, DP, Rows, Cols, R-1, C-1).

has_apple(DP, Row1, Col1, Row2, Col2, Rows, Cols) ->
    array:get({Rows-1, Cols-1}, DP) - array:get({Row1-1, Cols-1}, DP) - array:get({Rows-1, Col1-1}, DP) + array:get({Row1-1, Col1-1}, DP) > 0.

memo(DP, Row, Col, 1, Rows, Cols) ->
    case has_apple(DP, Row+1, Col+1, Rows, Cols, Rows, Cols) of
        true -> 1;
        false -> 0
    end;
memo(DP, Row, Col, K, Rows, Cols) ->
    memo_helper(DP, Row, Col, K, Rows, Cols, 0).

memo_helper(DP, Row, Col, K, Rows, Cols, Acc) ->
    Acc1 = foldl(fun(R, Acc0) ->
                         case has_apple(DP, Row+1, Col+1, Row+R, Cols, Rows, Cols) of
                             true -> (Acc0 + memo(DP, Row+R, Col, K-1, Rows, Cols)) rem 1000000007;
                             false -> Acc0
                         end
                     end, Acc, lists:seq(1, Rows-Row-1)),
    Acc2 = foldl(fun(C, Acc0) ->
                         case has_apple(DP, Row+1, Col+1, Rows, Col+C, Rows, Cols) of
                             true -> (Acc0 + memo(DP, Row, Col+C, K-1, Rows, Cols)) rem 1000000007;
                             false -> Acc0
                         end
                     end, Acc1, lists:seq(1, Cols-Col-1)),
    Acc2.

foldl(Fun, Acc, []) ->
    Acc;
foldl(Fun, Acc, [H|T]) ->
    foldl(Fun, Fun(H, Acc), T).