-module(right_side_view).
-export([right_side_view/1]).

right_side_view(Root) ->
  right_side_view(Root, []).

right_side_view(Root, Acc) ->
  case Root of
    null ->
      lists:reverse(Acc);
    _ ->
      right_side_view_helper([Root], []).

right_side_view_helper([], Acc) ->
  lists:reverse(Acc);
right_side_view_helper(Q, Acc) ->
  case Q of
    [] ->
      lists:reverse(Acc);
    _ ->
      Rightmost = lists:last(Q),
      NextLevel = lists:foldl(fun(Node, Acc2) ->
                                  case Node of
                                    null ->
                                      Acc2;
                                    {Val, Left, Right} ->
                                      case Left of
                                        null ->
                                          case Right of
                                            null ->
                                              Acc2;
                                            _ ->
                                              [Right | Acc2]
                                          end;
                                        _ ->
                                          case Right of
                                            null ->
                                              [Left | Acc2];
                                            _ ->
                                              [Right, Left | Acc2]
                                          end
                                      end;
                                    _ ->
                                      Acc2
                                  end
                                end, [], Q),
      right_side_view_helper(lists:reverse(NextLevel), [element(1,Rightmost) | Acc])
  end.