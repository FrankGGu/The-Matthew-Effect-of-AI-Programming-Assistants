-module(map_sum).
-export([new/0, insert/2, sum/1]).

new() ->
    {dict:new(), dict:new()}.

insert(Key, Val, {Map, SumMap}) ->
    case dict:find(Key, Map) of
        {ok, OldVal} ->
            NewSumMap = dict:update(Key, Val - OldVal, SumMap);
            {dict:store(Key, Val, Map), NewSumMap};
        error ->
            NewSumMap = dict:store(Key, Val, SumMap);
            {dict:store(Key, Val, Map), NewSumMap}
    end.

sum(Prefix, {_, SumMap}) ->
    dict:fold(fun(Key, Val, Acc) ->
                      case string:prefix(Key, Prefix) of
                          true -> Acc + Val;
                          false -> Acc
                      end
              end, 0, SumMap).