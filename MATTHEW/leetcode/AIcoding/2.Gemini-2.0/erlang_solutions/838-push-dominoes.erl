-module(push_dominoes).
-export([push_dominoes/1]).

push_dominoes(S) ->
  push_dominoes(string:to_list(S), []).

push_dominoes(Dominoes, Acc) ->
  Len = length(Dominoes),
  NewDominoes = push_dominoes_helper(Dominoes, Len, 0, []),
  if NewDominoes == Dominoes then
    list_to_binary(lists:reverse(Acc ++ NewDominoes))
  else
    push_dominoes(NewDominoes, Acc ++ NewDominoes)
  end.

push_dominoes_helper([], _Len, _Index, Acc) ->
  lists:reverse(Acc);
push_dominoes_helper(Dominoes, Len, Index, Acc) ->
  case Dominoes of
    [$. | Rest] ->
      {Left, Right} = get_adjacent(Dominoes, Index, Len),
      case {Left, Right} of
        {<<"R">>, <<"L">>} ->
          push_dominoes_helper(Rest, Len, Index + 1, [$. | Acc]);
        {<<"R">>, <<".">>} ->
          push_dominoes_helper(Rest, Len, Index + 1, [<<"R">> | Acc]);
        {<<".">>, <<"L">>} ->
          push_dominoes_helper(Rest, Len, Index + 1, [<<"L">> | Acc]);
        _ ->
          push_dominoes_helper(Rest, Len, Index + 1, [$. | Acc])
      end;
    [H | Rest] ->
      push_dominoes_helper(Rest, Len, Index + 1, [H | Acc])
  end.

get_adjacent(Dominoes, Index, Len) ->
  Left =
    case Index of
      0 ->
        <<".">>;
      _ ->
        get_left(Dominoes, Index)
    end,
  Right =
    case Index of
      Len - 1 ->
        <<".">>;
      _ ->
        get_right(Dominoes, Index)
    end,
  {Left, Right}.

get_left(Dominoes, Index) ->
  get_left_helper(Dominoes, Index - 1).

get_left_helper(Dominoes, Index) ->
  case lists:nth(Index + 1, Dominoes) of
    $. ->
      if Index =:= 0 then
        <<".">>
      else
        get_left_helper(Dominoes, Index - 1)
      end;
    Char ->
      list_to_binary([Char])
  end.

get_right(Dominoes, Index) ->
  get_right_helper(lists:sublist(Dominoes, Index + 2, length(Dominoes) - Index - 1)).

get_right_helper([]) ->
  <<".">>;
get_right_helper([H | _]) ->
  case H of
    $. ->
      <<".">>;
    Char ->
      list_to_binary([Char])
  end.