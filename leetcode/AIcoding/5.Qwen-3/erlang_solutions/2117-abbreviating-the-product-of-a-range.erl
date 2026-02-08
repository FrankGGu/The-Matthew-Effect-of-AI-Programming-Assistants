-module(abbreviating_the_product_of_a_range).
-export([abbreviation/2]).

abbreviation(Start, End) ->
    {Product, Count} = product_and_count(Start, End),
    shorten(Product, Count).

product_and_count(Start, End) ->
    product_and_count(Start, End, 1, 0).

product_and_count(N, End, Product, Count) when N > End ->
    {Product, Count};
product_and_count(N, End, Product, Count) ->
    case N of
        _ when N rem 10 == 0 ->
            product_and_count(N + 1, End, Product * (N div 10), Count + 1);
        _ ->
            product_and_count(N + 1, End, Product * N, Count)
    end.

shorten(Product, Count) ->
    MaxLen = 10,
    Str = integer_to_list(Product),
    Len = length(Str),
    if
        Len =< MaxLen ->
            lists:sublist(Str, MaxLen) ++ "e" ++ integer_to_list(Count);
        true ->
            First = lists:sublist(Str, 5),
            Last = lists:sublist(Str, -5),
            First ++ "..." ++ Last ++ "e" ++ integer_to_list(Count)
    end.