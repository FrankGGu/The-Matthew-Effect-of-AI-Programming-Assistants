-module(solution).
-export([find_products_with_valid_serial_numbers/1]).

find_products_with_valid_serial_numbers(Products) ->
    lists:filter(fun({_ProductId, SerialNumberString}) -> is_valid_serial_number(SerialNumberString) end, Products).

is_valid_serial_number(SNString) when is_list(SNString) ->
    case string:prefix(SNString, "SN") of
        nomatch -> false;
        {match, Rest} ->
            length(Rest) == 5 andalso lists:all(fun(C) -> C >= $0 andalso C <= $9 end, Rest)
    end;
is_valid_serial_number(_) ->
    false.