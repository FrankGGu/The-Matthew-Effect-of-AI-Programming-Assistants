-module(punishment_number).
-export([find_punishment_number/1]).

find_punishment_number(N) ->
  lists:sum([I || I <- lists:seq(1, N), is_punishment_number(I)]).

is_punishment_number(N) ->
  NumStr = integer_to_list(N),
  is_punishment_number_helper(NumStr, 0, N).

is_punishment_number_helper([], Sum, Target) ->
  Sum == Target;
is_punishment_number_helper(Digits, Sum, Target) ->
  lists:any(fun(Len) ->
    try
      SubStr = lists:sublist(Digits, Len),
      Value = list_to_integer(SubStr),
      Rest = lists:nthtail(Len, Digits),
      is_punishment_number_helper(Rest, Sum + Value, Target)
    catch
      _:_ ->
        false
    end
  end, lists:seq(1, length(Digits))).