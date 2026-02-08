-module(verbal_arithmetic).
-export([solve/1]).

solve(Words) ->
  solve(Words, []).

solve(Words, Assignment) ->
  Vars = lists:usort(string:to_list(lists:flatten(Words))),
  solve(Words, Assignment, Vars, []).

solve(Words, Assignment, [], Used) ->
  Result = evaluate(Words, Assignment),
  if Result == 0 then
    true
  else
    false
  end;
solve(Words, Assignment, [Var | Rest], Used) ->
  lists:any(fun(Digit) ->
              not lists:member(Digit, Used) andalso
                solve(Words, [{Var, Digit} | Assignment], Rest, [Digit | Used])
            end, lists:seq(0, 9)).

evaluate(Words, Assignment) ->
  N = length(Words) - 1,
  Sum = lists:sum(lists:sublist(lists:map(fun(Word) -> to_number(Word, Assignment)), 1, N)),
  to_number(lists:last(Words), Assignment) - Sum.

to_number(Word, Assignment) ->
  Digits = string:to_list(Word),
  case lists:keyfind(hd(Digits), 1, Assignment) of
    false ->
      0;
    _ ->
      to_number_helper(Digits, Assignment, 0)
  end.

to_number_helper([], _, Acc) ->
  Acc;
to_number_helper([Digit | Rest], Assignment, Acc) ->
  Value = lists:keyfind(Digit, 1, Assignment),
  case Value of
    {Digit, Num} ->
      to_number_helper(Rest, Assignment, Acc * 10 + Num);
    false ->
      0
  end.