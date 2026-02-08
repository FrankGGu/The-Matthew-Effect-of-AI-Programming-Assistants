-module(construct_product_matrix).
-export([product_matrix/1]).

product_matrix(Grid) ->
    N = length(Grid),
    M = length(hd(Grid)),
    {Product, ZeroCount} = product_and_zero_count(Grid),
    Result = lists:map(
        fun(Row) ->
            lists:map(
                fun(Element) ->
                    case ZeroCount of
                        0 ->
                            (Product div Element) rem 12345,
                        1 ->
                            case Element of
                                0 -> Product rem 12345;
                                _ -> 0
                            end;
                        _ ->
                            0
                    end
                end,
                Row
            )
        end,
        Grid
    ).

product_and_zero_count(Grid) ->
    product_and_zero_count_helper(Grid, 1, 0).

product_and_zero_count_helper([], Product, ZeroCount) ->
    {Product, ZeroCount};
product_and_zero_count_helper([Row | Rest], AccProduct, AccZeroCount) ->
    {NewProduct, NewZeroCount} = row_product_and_zero_count(Row, AccProduct, AccZeroCount),
    product_and_zero_count_helper(Rest, NewProduct, NewZeroCount).

row_product_and_zero_count([], Product, ZeroCount) ->
    {Product, ZeroCount};
row_product_and_zero_count([Element | Rest], AccProduct, AccZeroCount) ->
    case Element of
        0 ->
            row_product_and_zero_count(Rest, AccProduct, AccZeroCount + 1);
        _ ->
            row_product_and_zero_count(Rest, (AccProduct * Element) rem 12345, AccZeroCount)
    end.