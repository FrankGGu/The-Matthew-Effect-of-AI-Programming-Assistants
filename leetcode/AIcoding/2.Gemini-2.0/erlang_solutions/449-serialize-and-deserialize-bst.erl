-module(serialize_deserialize_bst).
-export([serialize/1, deserialize/1]).

serialize(Tree) ->
  serialize_helper(Tree, []).

serialize_helper(null, Acc) ->
  lists:reverse(Acc);
serialize_helper({Val, Left, Right}, Acc) ->
  serialize_helper(Left, [integer_to_list(Val), "," | serialize_helper(Right, Acc)]).

deserialize(Data) ->
  deserialize_helper(string:tokens(Data, ","), []).

deserialize_helper([], Acc) ->
  case Acc of
    [] -> null;
    [H|_] -> H
  end;
deserialize_helper(Tokens, Acc) ->
  {Tree, Rest} = deserialize_tree(Tokens),
  deserialize_helper(Rest, [Tree | Acc]).

deserialize_tree([]) ->
  {null, []};
deserialize_tree(Tokens) ->
  case Tokens of
    [] -> {null, []};
    [[]|Rest] -> {null, Rest};
    [Token|Rest] ->
      try
        Val = list_to_integer(Token),
        {Left, Rest1} = deserialize_tree(Rest),
        {Right, Rest2} = deserialize_tree(Rest1),
        {{Val, Left, Right}, Rest2}
      catch
        _:_ -> {null, Tokens}
      end
  end.