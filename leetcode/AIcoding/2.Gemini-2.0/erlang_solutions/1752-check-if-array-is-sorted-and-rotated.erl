-module(is_sorted_and_rotated).
-export([check/1]).

check(Nums) ->
  check(Nums, 0).

check([H|T], Count) ->
  case T of
    [] -> Count =< 1;
    [H2|T2] ->
      case H > H2 of
        true -> check(T, Count + 1);
        false -> check(T, Count)
      end
  end.

check(Nums, Count) ->
  case length(Nums) < 2 of
    true -> true;
    false ->
      case lists:last(Nums) > lists:nth(Nums,0) of
        true ->
          check(Nums, Count + 1);
        false ->
          case check(Nums, Count) of
            true ->
              (check(Nums,Count) and (check(lists:sublist(Nums,2,length(Nums)-1) ++ [lists:nth(Nums,0)],0)));
            false -> false
          end
      end
  end.

check(Nums, Count) when length(Nums) > 1 ->
  case lists:last(Nums) > lists:nth(Nums,0) of
    true ->
      check(Nums, Count + 1);
    false ->
      case check(Nums, Count) of
        true ->
          (check(Nums,Count) and (check(lists:sublist(Nums,2,length(Nums)-1) ++ [lists:nth(Nums,0)],0)));
        false -> false
      end
  end.

check(Nums, Count) when length(Nums) == 0 -> true;
check(Nums, Count) when length(Nums) == 1 -> true;

check(Nums, Count) ->
  case Count > 1 of
    true -> false;
    false ->
      NewNums = lists:sublist(Nums,2,length(Nums)-1) ++ [lists:nth(Nums,0)],
      case check(NewNums,0) of
        true -> true;
        false -> false
      end
  end.

check2([]) -> true;
check2([_]) -> true;
check2([H1,H2|T]) ->
  case H1 > H2 of
    true -> false;
    false -> check2([H2|T])
  end.

check3(Nums) ->
  Len = length(Nums),
  check3(Nums,Len).

check3(Nums,Len) ->
  case Len < 2 of
    true -> true;
    false ->
      case lists:last(Nums) > lists:nth(Nums,0) of
        true -> false;
        false ->
          NewNums = lists:sublist(Nums,2,length(Nums)-1) ++ [lists:nth(Nums,0)],
          check3(NewNums,Len)
      end
  end.

check4(Nums) ->
  N = length(Nums),
  DecreasingCount = 0,
  lists:foldl(fun(I, Acc) ->
                  case lists:nth(Nums, I) > lists:nth(Nums, (I + 1) rem N) of
                    true -> Acc + 1;
                    false -> Acc
                  end
              end, 0, lists:seq(1, N)),
  DecreasingCount =< 1.