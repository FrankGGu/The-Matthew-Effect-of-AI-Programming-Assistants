-module(deep_dark_fraction).
-export([fraction_addition/1]).

fraction_addition(expression) ->
  parse_expression(expression, 0, 1, 1).

parse_expression([], Numerator, Denominator, Sign) ->
  simplify_fraction(Numerator * Sign, Denominator);
parse_expression([$+ | Rest], Numerator, Denominator, Sign) ->
  parse_expression(Rest, Numerator, Denominator, 1);
parse_expression([$- | Rest], Numerator, Denominator, Sign) ->
  parse_expression(Rest, Numerator, Denominator, -1 * Sign);
parse_expression(Expression, Numerator, Denominator, Sign) ->
  {Num, Rest1} = parse_number(Expression, []),
  {_, Rest2} = lists:splitwith(fun(X) -> X == '/' end, Rest1),
  {Den, Rest} = parse_number(tl(Rest2), []),
  NewNum = (Numerator * Den) + (Num * Denominator * Sign),
  NewDen = Denominator * Den,
  parse_expression(Rest, NewNum, NewDen, 1).

parse_number(Chars, Acc) ->
  parse_number_helper(Chars, Acc, []).

parse_number_helper([], Acc, Result) ->
  {list_to_integer(lists:reverse(Result)), Acc};
parse_number_helper([H | T], Acc, Result) when H >= $0, H =< $9 ->
  parse_number_helper(T, Acc, [H | Result]);
parse_number_helper(Chars, Acc, Result) ->
  {list_to_integer(lists:reverse(Result)), Chars}.

simplify_fraction(Numerator, Denominator) ->
  GCD = gcd(abs(Numerator), abs(Denominator)),
  [integer_to_list(Numerator div GCD), "/", integer_to_list(Denominator div GCD)].

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).