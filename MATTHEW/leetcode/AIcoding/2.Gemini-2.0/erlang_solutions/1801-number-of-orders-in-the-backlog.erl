-module(backlog_orders).
-export([get_number_of_backlog_orders/1]).

get_number_of_backlog_orders(Orders) ->
  {BuyHeap, SellHeap} = lists:foldl(
    fun({Price, Amount, OrderType}, {BuyAcc, SellAcc}) ->
      case OrderType of
        0 ->
          process_buy(Price, Amount, SellAcc, BuyAcc);
        1 ->
          process_sell(Price, Amount, BuyAcc, SellAcc)
      end
    end,
    {[], []},
    Orders
  ),
  BuySum = heap_sum(BuyHeap),
  SellSum = heap_sum(SellHeap),
  (BuySum + SellSum) rem (1000000000 + 7).

process_buy(Price, Amount, SellAcc, BuyAcc) ->
  case SellAcc of
    [] ->
      {lists:append(BuyAcc, [{Price, Amount}]), SellAcc};
    [{SellPrice, SellAmount} | RestSell] ->
      case Price >= SellPrice of
        true ->
          case Amount >= SellAmount of
            true ->
              process_buy(Price, Amount - SellAmount, RestSell, BuyAcc);
            false ->
              {lists:append(BuyAcc, []), [{SellPrice, SellAmount - Amount} | RestSell]}
          end;
        false ->
          {lists:append(BuyAcc, [{Price, Amount}]), SellAcc}
      end
  end.

process_sell(Price, Amount, BuyAcc, SellAcc) ->
  case BuyAcc of
    [] ->
      {BuyAcc, lists:append(SellAcc, [{Price, Amount}])};
    [{BuyPrice, BuyAmount} | RestBuy] ->
      case Price <= BuyPrice of
        true ->
          case Amount >= BuyAmount of
            true ->
              process_sell(Price, Amount - BuyAmount, RestBuy, SellAcc);
            false ->
              {[{BuyPrice, BuyAmount - Amount} | RestBuy], lists:append(SellAcc, [])}
          end;
        false ->
          {BuyAcc, lists:append(SellAcc, [{Price, Amount}])}
      end
  end.

heap_sum(Heap) ->
  lists:foldl(fun({_, Amount}, Acc) -> (Acc + Amount) rem (1000000000 + 7) end, 0, Heap).