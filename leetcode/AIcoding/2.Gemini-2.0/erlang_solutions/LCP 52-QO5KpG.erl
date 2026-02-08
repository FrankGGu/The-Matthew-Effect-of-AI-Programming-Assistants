-module(bst_coloring).
-export([get_kth_color_node/3]).

get_kth_color_node(Root, K, Color) ->
  get_kth_color_node(Root, K, Color, 0, []).

get_kth_color_node(null, K, Color, Acc, AccList) ->
  {null, K, Acc, AccList};
get_kth_color_node({Val, Left, Right}, K, Color, Acc, AccList) ->
  {LeftResult, LeftK, LeftAcc, LeftAccList} = get_kth_color_node(Left, K, Color, Acc, AccList),
  case LeftResult of
    null ->
      case Val =:= Color of
        true ->
          NewAcc = LeftAcc + 1,
          case NewAcc =:= LeftK of
            true ->
              {Val, 0, NewAcc, LeftAccList};
            false ->
              {RightResult, RightK, RightAcc, RightAccList} = get_kth_color_node(Right, LeftK, Color, NewAcc, LeftAccList),
              case RightResult of
                null -> {null, RightK, RightAcc, RightAccList};
                _ -> {RightResult, 0, RightAcc, RightAccList}
              end
          end;
        false ->
          {RightResult, RightK, RightAcc, RightAccList} = get_kth_color_node(Right, LeftK, Color, LeftAcc, LeftAccList),
          case RightResult of
            null -> {null, RightK, RightAcc, RightAccList};
            _ -> {RightResult, 0, RightAcc, RightAccList}
          end
      end;
    _ -> {LeftResult, 0, LeftAcc, LeftAccList}
  end.