-module(largest_multiple_of_three).
-export([largest_multiple_of_three/1]).

largest_multiple_of_three(Digits) ->
  {Counts, Sum} = lists:foldl(
    fun(Digit, {AccCounts, AccSum}) ->
      {AccCounts#{Digit => maps:get(Digit, AccCounts, 0) + 1}, AccSum + Digit}
    end,
    {#{}, 0},
    Digits
  ),

  case Sum rem 3 of
    0 ->
      lists:reverse(lists:sort(Digits));
    1 ->
      case maps:get(1, Counts, 0) of
        N when N > 0 ->
          Digits1 = remove_one(Digits, 1);
          case is_empty_list(Digits1) of
            true ->
              case maps:get(2, Counts, 0) of
                M when M > 1 ->
                  Digits2 = remove_two(Digits, 2);
                  case is_empty_list(Digits2) of
                    true ->
                      [];
                    false ->
                      lists:reverse(lists:sort(Digits2))
                  end;
                _ ->
                  []
              end;
            false ->
              case maps:get(2, Counts, 0) of
                M when M > 1 ->
                  Digits2 = remove_two(Digits, 2);
                  case is_empty_list(Digits2) of
                    true ->
                      lists:reverse(lists:sort(Digits1));
                    false ->
                      if sum_list(Digits1) > sum_list(Digits2) then
                        lists:reverse(lists:sort(Digits1))
                      else
                        lists:reverse(lists:sort(Digits2))
                      end
                  end;
                _ ->
                  lists:reverse(lists:sort(Digits1))
              end
          end;
        _ ->
          case maps:get(2, Counts, 0) of
            M when M > 1 ->
              Digits2 = remove_two(Digits, 2);
              case is_empty_list(Digits2) of
                true ->
                  [];
                false ->
                  lists:reverse(lists:sort(Digits2))
              end;
            _ ->
              []
          end
      end;
    2 ->
      case maps:get(2, Counts, 0) of
        N when N > 0 ->
          Digits1 = remove_one(Digits, 2);
          case is_empty_list(Digits1) of
            true ->
              case maps:get(1, Counts, 0) of
                M when M > 1 ->
                  Digits2 = remove_two(Digits, 1);
                  case is_empty_list(Digits2) of
                    true ->
                      [];
                    false ->
                      lists:reverse(lists:sort(Digits2))
                  end;
                _ ->
                  []
              end;
            false ->
              case maps:get(1, Counts, 0) of
                M when M > 1 ->
                  Digits2 = remove_two(Digits, 1);
                  case is_empty_list(Digits2) of
                    true ->
                      lists:reverse(lists:sort(Digits1));
                    false ->
                      if sum_list(Digits1) > sum_list(Digits2) then
                        lists:reverse(lists:sort(Digits1))
                      else
                        lists:reverse(lists:sort(Digits2))
                      end
                  end;
                _ ->
                  lists:reverse(lists:sort(Digits1))
              end
          end;
        _ ->
          case maps:get(1, Counts, 0) of
            M when M > 1 ->
              Digits2 = remove_two(Digits, 1);
              case is_empty_list(Digits2) of
                true ->
                  [];
                false ->
                  lists:reverse(lists:sort(Digits2))
              end;
            _ ->
              []
          end
      end
  end
  ->
  format_result(lists:reverse(lists:sort(Digits))).

remove_one(Digits, Num) ->
  remove_one_helper(Digits, Num, []).

remove_one_helper([], _, Acc) ->
  lists:reverse(Acc);
remove_one_helper([H | T], Num, Acc) ->
  if H =:= Num then
    lists:reverse(Acc) ++ T
  else
    remove_one_helper(T, Num, [H | Acc])
  end.

remove_two(Digits, Num) ->
  remove_two_helper(Digits, Num, [], 0).

remove_two_helper([], _, Acc, Count) ->
  if Count < 2 then
    []
  else
    lists:reverse(Acc)
  end;
remove_two_helper([H | T], Num, Acc, Count) ->
  if H =:= Num andalso Count < 2 then
    remove_two_helper(T, Num, Acc, Count + 1)
  else
    remove_two_helper(T, Num, [H | Acc], Count)
  end.

is_empty_list([]) -> true;
is_empty_list(_) -> false.

sum_list(List) ->
  lists:sum(List).

format_result(Digits) ->
  case Digits of
    [] -> "";
    [0] -> "0";
    _ ->
      S = lists:flatten([integer_to_list(D) || D <- Digits]),
      case string:equal(S, "") of
        true -> "";
        false -> S
      end
  end.