-module(max_pair_sum).
-export([max_sum/1]).

max_sum(Nums) ->
  lists:foldl(fun(X, Acc) ->
                  Digits = digits(X),
                  MaxDigit = max_digit(Digits),
                  case maps:is_key(MaxDigit, Acc) of
                    true ->
                      case X > maps:get(MaxDigit, Acc) of
                        true ->
                          maps:update(MaxDigit, X, Acc);
                        false ->
                          Acc
                      end;
                    false ->
                      maps:put(MaxDigit, X, Acc)
                  end
              end, #{}, Nums),
  find_max_pair_sum(maps:values(maps:from_list(lists:sort(maps:to_list(lists:foldl(fun(X, Acc) ->
                                 Digits = digits(X),
                                 MaxDigit = max_digit(Digits),
                                 case maps:is_key(MaxDigit, Acc) of
                                   true ->
                                     case X > maps:get(MaxDigit, Acc) of
                                       true ->
                                         maps:update(MaxDigit, X, Acc);
                                       false ->
                                         Acc
                                     end;
                                   false ->
                                     maps:put(MaxDigit, X, Acc)
                                 end
                             end, #{}, Nums))))).

digits(N) ->
  digits(N, []).

digits(0, Acc) ->
  lists:reverse(Acc);
digits(N, Acc) ->
  digits(N div 10, [N rem 10 | Acc]).

max_digit(Digits) ->
  lists:max(Digits).

find_max_pair_sum(Values) ->
  find_max_pair_sum(Values, -1).

find_max_pair_sum([], MaxSum) ->
  MaxSum;
find_max_pair_sum([A, B | Rest], MaxSum) ->
  find_max_pair_sum([B | Rest], max(MaxSum, A + B));
find_max_pair_sum([_], MaxSum) ->
  MaxSum.