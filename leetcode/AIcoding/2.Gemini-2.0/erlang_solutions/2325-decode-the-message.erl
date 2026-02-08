-module(decode_message).
-export([decode_message/2]).

decode_message(Key, Message) ->
  Dict = create_dict(Key),
  lists:map(fun(C) ->
    case C of
      $\s -> $\s;
      _ -> maps:get(C, Dict)
    end
  end, Message).

create_dict(Key) ->
  create_dict_helper(Key, [], 0, #{}).

create_dict_helper([], _, _, Dict) ->
  Dict;
create_dict_helper([H|T], Seen, Count, Dict) ->
  case lists:member(H, Seen) of
    true ->
      create_dict_helper(T, Seen, Count, Dict);
    false ->
      NewDict = maps:put(H, $a + Count, Dict),
      create_dict_helper(T, [H|Seen], Count + 1, NewDict)
  end.