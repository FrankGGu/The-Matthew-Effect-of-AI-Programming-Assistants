-module(zuma_game).
-export([findMinStep/2]).

findMinStep(Board, Hand) ->
  findMinStepHelper(list_to_tuple(string_to_list(Board)), sort_hand(string_to_list(Hand)), []).

findMinStepHelper(Board, Hand, Visited) ->
  case clean(Board) of
    "" -> 0;
    CleanBoard ->
      case lists:member(CleanBoard, Visited) of
        true -> -1;
        false ->
          case Hand of
            [] -> -1;
            [H|RestHand] ->
              MinSteps = find_min_steps(CleanBoard, H, Hand, RestHand, Visited, 500),
              MinSteps
          end
      end
  end.

find_min_steps(Board, H, Hand, RestHand, Visited, Acc) ->
  Len = tuple_size(Board),
  find_min_steps_helper(Board, H, Hand, RestHand, Visited, Acc, 1, Len).

find_min_steps_helper(Board, H, Hand, RestHand, Visited, Acc, Index, Len) ->
  case Index > Len of
    true -> Acc;
    false ->
      case element(Index, Board) == H of
        true ->
          NewBoard = insert(Board, Index, H),
          NewVisited = [Board | Visited],
          NextSteps = findMinStepHelper(NewBoard, RestHand, NewVisited),
          case NextSteps == -1 of
            true ->
              find_min_steps_helper(Board, H, Hand, RestHand, Visited, Acc, Index + 1, Len);
            false ->
              NewAcc = min(Acc, 1 + NextSteps),
              find_min_steps_helper(Board, H, Hand, RestHand, Visited, NewAcc, Index + 1, Len)
          end;
        false ->
          NewBoard = insert(Board, Index, H),
          NewVisited = [Board | Visited],
          NextSteps = findMinStepHelper(NewBoard, RestHand, NewVisited),
          case NextSteps == -1 of
            true ->
              find_min_steps_helper(Board, H, Hand, RestHand, Visited, Acc, Index + 1, Len);
            false ->
              NewAcc = min(Acc, 1 + NextSteps),
              find_min_steps_helper(Board, H, Hand, RestHand, Visited, NewAcc, Index + 1, Len)
          end
      end
  end.

insert(Board, Index, H) ->
  Len = tuple_size(Board),
  Prefix = lists:sublist(tuple_to_list(Board), 1, Index - 1),
  Suffix = lists:sublist(tuple_to_list(Board), Index, Len - Index + 1),
  list_to_tuple(Prefix ++ [H] ++ Suffix).

clean(Board) ->
  clean_helper(tuple_to_list(Board)).

clean_helper(List) ->
  case clean_once(List) of
    NewList when NewList == List ->
      list_to_string(NewList);
    NewList ->
      clean_helper(NewList)
  end.

clean_once(List) ->
  clean_once_helper(List, []).

clean_once_helper([], Acc) ->
  lists:reverse(Acc);
clean_once_helper([H|T], Acc) ->
  {NewList, NewAcc} = check_and_remove([H|T], Acc, H, 1),
  NewList ++ lists:reverse(NewAcc).

check_and_remove([], Acc, _, _) ->
  {[], Acc};
check_and_remove([H|T], Acc, Color, Count) ->
  case H == Color of
    true ->
      check_and_remove(T, [], H, Count + 1);
    false ->
      case Count >= 3 of
        true ->
          {T, Acc};
        false ->
          {[H|T], lists:reverse(Acc ++ lists:duplicate(Count, Color))};
      end
  end.

sort_hand(Hand) ->
  lists:sort(Hand).

string_to_list(String) ->
  string:to_list(String).