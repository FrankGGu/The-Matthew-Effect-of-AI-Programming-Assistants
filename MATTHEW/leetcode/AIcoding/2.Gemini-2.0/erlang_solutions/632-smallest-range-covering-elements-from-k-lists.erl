-module(smallest_range).
-export([smallest_range/1]).

smallest_range(Lists) ->
  smallest_range(Lists, [], [], math:inf(), -math:inf(), 0, 0).

smallest_range([], Acc, Result, MinRange, BestLeft, BestRight, BestI, BestJ) ->
  case Acc of
    [] -> [0, 0];
    _ ->
      [BestLeft, BestRight]
  end;
smallest_range(Lists, Acc, Result, MinRange, BestLeft, BestRight, BestI, BestJ) ->
  {Min, I, J} = find_min(Lists),
  Max = find_max(Lists),
  Range = Max - Min,
  case Range < MinRange of
    true ->
      NewBestLeft = Min,
      NewBestRight = Max,
      NewMinRange = Range,
      NewBestI = I,
      NewBestJ = J,
      NewLists = update_list(Lists, I),
      case NewLists of
        false ->
          [BestLeft, BestRight];
        _ ->
          smallest_range(NewLists, Acc, Result, NewMinRange, NewBestLeft, NewBestRight, NewBestI, NewBestJ)
      end;
    false ->
      NewLists = update_list(Lists, I),
      case NewLists of
        false ->
          [BestLeft, BestRight];
        _ ->
          smallest_range(NewLists, Acc, Result, MinRange, BestLeft, BestRight, BestI, BestJ)
      end
  end.

find_min(Lists) ->
  find_min(Lists, math:inf(), -1, -1, 0, 0).

find_min([], Min, I, J, _, _) ->
  {Min, I, J};
find_min([[]|_], Min, I, J, _, _) ->
    {Min, I, J};
find_min([H|T], Min, I, J, Index, SubIndex) ->
  case hd(H) < Min of
    true ->
      find_min(T, hd(H), Index, 0, Index + 1, 0);
    false ->
      find_min(T, Min, I, J, Index + 1, 0)
  end.

find_max(Lists) ->
  find_max(Lists, -math:inf(), 0).

find_max([], Max, _) ->
  Max;
find_max([[]|_], Max, _) ->
    Max;
find_max([H|T], Max, _) ->
  find_max(T, max(Max, hd(lists:sort([hd(X) || X <- Lists, X /= []])), 0).

update_list(Lists, Index) ->
  update_list(Lists, Index, 0).

update_list([], _, _) ->
    false;

update_list([H|T], Index, CurrentIndex) ->
  case Index =:= CurrentIndex of
    true ->
      case tl(H) of
        [] ->
          case T of
            [] ->
              false;
            _ ->
              T
          end;
        NewH ->
          [NewH|T]
      end;
    false ->
      case T of
        [] ->
          false;
        _ ->
          [H|update_list(T, Index, CurrentIndex + 1)]
      end
  end.