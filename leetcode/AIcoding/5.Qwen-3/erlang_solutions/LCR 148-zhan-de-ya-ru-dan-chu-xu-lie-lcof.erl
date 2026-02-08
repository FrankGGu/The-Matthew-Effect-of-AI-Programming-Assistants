-module(verify_book_order).
-export([verifyOrder/2]).

verifyOrder(CheckOut, CheckIn) ->
    verifyOrder(CheckOut, CheckIn, []).

verifyOrder([], _, _) ->
    true;
verifyOrder([H|T], CheckIn, Stack) ->
    case lists:member(H, Stack) of
        true ->
            verifyOrder(T, CheckIn, Stack);
        false ->
            case lists:member(H, CheckIn) of
                true ->
                    NewStack = [H | Stack],
                    verifyOrder(T, lists:delete(H, CheckIn), NewStack);
                false ->
                    false
            end
    end.