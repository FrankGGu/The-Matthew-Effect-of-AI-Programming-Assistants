-module(fraction_addition).
-export([fractionAddition/1]).

fractionAddition(Expression) ->
    Tokens = re:split(Expression, "(\\+|-)", [{return, list}]),
    Fracs = lists:drop(1, Tokens),
    Signs = [case Sign of "+" -> 1; "-" -> -1 end || Sign <- re:split(Expression, "[^\\+\\-]", [{return, list}]), Sign /= ""],

    parse_fractions(Fracs, Signs, {0, 1}).

parse_fractions([], [], Acc) ->
    {Num, Den} = Acc,
    GCD = gcd(abs(Num), Den),
    io_lib:format("~p/~p", [Num div GCD, Den div GCD]);
parse_fractions([Frac | RestFracs], [Sign | RestSigns], Acc) ->
    [NumStr, DenStr] = string:split(Frac, "/", all),
    Num = list_to_integer(NumStr) * Sign,
    Den = list_to_integer(DenStr),
    {AccNum, AccDen} = Acc,
    NewNum = AccNum * Den + Num * AccDen,
    NewDen = AccDen * Den,
    parse_fractions(RestFracs, RestSigns, {NewNum, NewDen}).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).