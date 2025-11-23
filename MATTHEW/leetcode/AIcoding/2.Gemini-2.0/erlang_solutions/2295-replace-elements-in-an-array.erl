-module(replace_elements).
-export([array_replace/2]).

array_replace(Nums, Operations) ->
  Map = lists:foldl(
    fun(Num, Acc) ->
      maps:put(Num, lists:keyfind(Num, 1, lists:enumerate(Nums)), Acc)
    end,
    maps:new(),
    Nums
  ),
  lists:foldl(
    fun([Old, New], {AccNums, AccMap}) ->
      case maps:is_key(Old, AccMap) of
        true ->
          {Index, _} = maps:get(Old, AccMap),
          NewAccNums = lists:replace(Index, New, AccNums),
          NewAccMap = maps:remove(Old, AccMap),
          {NewAccNums, maps:put(New, {Index, New}, NewAccMap)} ;
        false ->
          {AccNums, AccMap}
      end
    end,
    {Nums, Map},
    Operations
  ).
array_replace(Nums, Operations) ->
    {Result, _} = lists:foldl(
        fun([Old, New], {Acc, Map}) ->
            case maps:is_key(Old, Map) of
                true ->
                    Index = maps:get(Old, Map),
                    NewAcc = lists:replace(Index, New, Acc),
                    {NewAcc, maps:put(New, Index, maps:remove(Old, Map))};
                false ->
                    {Acc, Map}
            end
        end,
        {Nums, lists:foldl(fun({Index, Num}, Acc) -> maps:put(Num, Index, Acc) end, maps:new(), lists:zip(lists:seq(1, length(Nums)), Nums))},
        Operations
    ),
    Result.