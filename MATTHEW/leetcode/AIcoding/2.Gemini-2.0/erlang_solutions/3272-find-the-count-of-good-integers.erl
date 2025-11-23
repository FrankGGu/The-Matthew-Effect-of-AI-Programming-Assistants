-module(good_integers).
-export([find_good_integers/1]).

find_good_integers(N) ->
  memo(N).

memo(N) ->
  memo(N, create_memo()).

memo(0, Memo) ->
  maps:get({0, 0}, Memo);
memo(N, Memo) ->
  case maps:is_key({N, 0}, Memo) of
    true ->
      maps:get({N, 0}, Memo);
    false ->
      Result = calculate(N, Memo),
      NewMemo = maps:put({N, 0}, Result, Memo),
      Result
  end.

calculate(N, Memo) ->
  (calculate_helper(N, 0, Memo) + calculate_helper(N, 1, Memo)) rem 1000000007.

calculate_helper(0, _, _) ->
  1;
calculate_helper(N, PrevDigit, Memo) ->
  Sum = lists:foldl(
    fun(Digit, Acc) ->
      case PrevDigit of
        1 ->
          if Digit >= 0 ->
            (Acc + memo(N - 1, create_memo_with_n(N-1,Memo))) rem 1000000007
          else
            Acc
          end;
        0 ->
          if Digit =< 1 ->
            (Acc + memo(N - 1, create_memo_with_n(N-1,Memo))) rem 1000000007
          else
            Acc
          end
      end
    end,
    0,
    lists:seq(0, get_digit(N))
  ),
  Sum.

get_digit(N) ->
  list_to_integer(lists:nth(1, integer_to_list(N))).

create_memo() ->
  #{}.

create_memo_with_n(N, Memo) ->
  case maps:is_key({N, 0}, Memo) of
    true ->
      Memo;
    false ->
      Memo
  end.