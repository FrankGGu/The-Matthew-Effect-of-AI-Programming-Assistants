-module(kth_largest).
-export([kth_largest/2, add/2]).

kth_largest(K, Nums) ->
  {ok, Heap} = heap:new(),
  {NewHeap, _} = lists:foldl(fun(Num, {AccHeap, Count}) ->
                                   if Count < K ->
                                     {heap:insert(Num, AccHeap), Count + 1};
                                   true ->
                                     case heap:get_min(AccHeap) of
                                       {ok, Min} when Num > Min ->
                                         {heap:delete_min(heap:insert(Num, AccHeap)), Count};
                                       _ ->
                                         {AccHeap, Count}
                                     end
                               end, {Heap, 0}, Nums),
  {state, K, NewHeap}.

add({state, K, Heap}, Val) ->
  case heap:size(Heap) of
    Size when Size < K ->
      NewHeap = heap:insert(Val, Heap),
      {state, K, NewHeap},
      case heap:size(NewHeap) of
        Size2 when Size2 =:= K ->
          {ok, Min} = heap:get_min(NewHeap),
          Min;
        _ ->
          element(1, heap:get_max(NewHeap))
      end;
    _ ->
      case heap:get_min(Heap) of
        {ok, Min} when Val > Min ->
          NewHeap = heap:delete_min(heap:insert(Val, Heap)),
          {state, K, NewHeap},
          {ok, Min2} = heap:get_min(NewHeap),
          Min2;
        _ ->
          {state, K, Heap},
          {ok, Min3} = heap:get_min(Heap),
          Min3
      end
  end.