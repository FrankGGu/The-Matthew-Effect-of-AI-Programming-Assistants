-module(max_value_k_coins).
-export([max_value_of_coins/2]).

max_value_of_coins(Piles, K) ->
    length(Piles) ->
        N = length(Piles),
        dp(Piles, N, K, []).

dp(_Piles, 0, _K, Acc) ->
    lists:reverse(Acc);
dp(Piles, N, K, Acc) ->
    case N =:= 1 of
        true ->
            [
                begin
                    Sum = lists:sum(lists:sublist(hd(Piles), 1, I)),
                    {I, Sum}
                end
             || I <- lists:seq(0, min(K, length(hd(Piles))))
            ] ++ Acc;
        false ->
            PilesN = lists:nth(N, Piles),
            dp(Piles, N-1, K, [
                begin
                    Sum = lists:sum(lists:sublist(PilesN, 1, I)),
                    {I, Sum}
                end
             || I <- lists:seq(0, min(K, length(PilesN)))] ++ Acc
    end.

max_value_of_coins_helper(Piles, K) ->
    N = length(Piles),
    lists:foldl(fun(Pile, Acc) ->
        [lists:sum(lists:sublist(Pile, 1, I)) || I <- lists:seq(0, min(K, length(Pile)))] ++ Acc
    end, [], Piles).

max_value_of_coins(Piles, K) ->
    N = length(Piles),
    Memo = dict:new(),
    max_value_of_coins_helper(Piles, N, K, Memo).

max_value_of_coins_helper(_Piles, 0, _K, _Memo) ->
    0;
max_value_of_coins_helper(Piles, N, K, Memo) ->
    case dict:is_key({N, K}, Memo) of
        true ->
            dict:fetch({N, K}, Memo);
        false ->
            Pile = lists:nth(N, Piles),
            MaxVal = lists:foldl(fun(X, Acc) ->
                if X > K then
                    Acc
                else
                    Val = (
                        case X of
                            0 ->
                                max_value_of_coins_helper(Piles, N-1, K, Memo);
                            _ ->
                                lists:sum(lists:sublist(Pile, 1, X)) + max_value_of_coins_helper(Piles, N-1, K-X, Memo)
                        end
                    ),
                    max(Acc, Val)
                end
            end, 0, lists:seq(0, min(K, length(Pile)))),
            NewMemo = dict:store({N, K}, MaxVal, Memo),
            MaxVal
    end.