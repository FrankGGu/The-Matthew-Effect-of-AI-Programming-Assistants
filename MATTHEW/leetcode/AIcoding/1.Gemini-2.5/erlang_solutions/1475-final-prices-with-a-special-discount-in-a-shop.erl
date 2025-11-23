-module(solution).
-export([final_prices/1]).

final_prices(Prices) ->
    Len = length(Prices),
    PricesArray = array:from_list(Prices),
    ResultArray = array:from_list(Prices),
    Stack = [],
    final_prices_loop(0, Len, PricesArray, ResultArray, Stack).

final_prices_loop(Idx, Len, PricesArray, ResultArray, Stack) when Idx < Len ->
    CurrentPrice = array:get(Idx, PricesArray),
    {NewResultArray, NewStack} = apply_discounts(CurrentPrice, PricesArray, ResultArray, Stack),
    UpdatedStack = [Idx | NewStack],
    final_prices_loop(Idx + 1, Len, PricesArray, UpdatedResultArray, UpdatedStack);
final_prices_loop(_Idx, _Len, _PricesArray, ResultArray, _Stack) ->
    array:to_list(ResultArray).

apply_discounts(CurrentPrice, PricesArray, ResultArray, Stack) ->
    case Stack of
        [] ->
            {ResultArray, []};
        [PrevIdx | RestStack] ->
            PrevPrice = array:get(PrevIdx, PricesArray),
            if PrevPrice >= CurrentPrice ->
                DiscountedPrice = PrevPrice - CurrentPrice,
                UpdatedResultArray = array:set(PrevIdx, DiscountedPrice, ResultArray),
                apply_discounts(CurrentPrice, PricesArray, UpdatedResultArray, RestStack);
            true ->
                {ResultArray, Stack}
            end
    end.