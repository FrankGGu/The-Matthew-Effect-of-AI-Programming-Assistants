-module(map_sum).
-export([new/0, insert/2, sum/1]).

new() -> dict:new().

insert(Key, Val, Dict) ->
  dict:store(Key, Val, Dict).

sum(Prefix, Dict) ->
  sum_prefix(Prefix, Dict, 0).

sum_prefix(Prefix, Dict, Acc) ->
  case dict:is_empty(Dict) of
    true ->
      Acc;
    false ->
      {Key, Val, NewDict} = dict:fetch_any(Dict),
      case string:prefix(Key, Prefix) of
        true ->
          sum_prefix(Prefix, NewDict, Acc + Val);
        false ->
          sum_prefix(Prefix, NewDict, Acc)
      end
  end.