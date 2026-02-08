-module(solution).
-export([fraction_addition/1]).

-spec fraction_addition(Expression :: unicode:unicode_binary()) -> unicode:unicode_binary().
fraction_addition(Expression) ->
    Fractions = parse_fractions(Expression),
    {N, D} = compute_sum(Fractions),
    simplify(N, D).

parse_fractions(Expression) ->
    parse_fractions(Expression, [], []).

parse_fractions(<<>>, AccNum, Acc) ->
    lists:reverse([{list_to_integer(lists:reverse(AccNum)), 1} | Acc]);
parse_fractions(<<$/, Rest/binary>>, AccNum, Acc) ->
    parse_denominator(Rest, [], {list_to_integer(lists:reverse(AccNum)), []}, Acc);
parse_fractions(<<C, Rest/binary>>, AccNum, Acc) ->
    parse_fractions(Rest, [C | AccNum], Acc).

parse_denominator(<<>>, AccDen, {Num, _}, Acc) ->
    lists:reverse([{Num, list_to_integer(lists:reverse(AccDen))} | Acc]);
parse_denominator(<<$+, Rest/binary>>, AccDen, {Num, _}, Acc) ->
    parse_fractions(Rest, [], [{Num, list_to_integer(lists:reverse(AccDen))} | Acc]);
parse_denominator(<<$-, Rest/binary>>, AccDen, {Num, _}, Acc) ->
    parse_fractions(Rest, [$-], [{Num, list_to_integer(lists:reverse(AccDen))} | Acc]);
parse_denominator(<<C, Rest/binary>>, AccDen, {Num, _}, Acc) ->
    parse_denominator(Rest, [C | AccDen], {Num, []}, Acc).

compute_sum(Fractions) ->
    {Numerators, Denominators} = lists:unzip(Fractions),
    D = lcm_list(Denominators),
    N = lists:sum([Num * (D div Den) || {Num, Den} <- Fractions]),
    {N, D}.

lcm_list(List) ->
    lists:foldl(fun lcm/2, 1, List).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

lcm(A, B) ->
    (A * B) div gcd(A, B).

simplify(N, D) ->
    G = gcd(abs(N), abs(D)),
    SimplifiedN = N div G,
    SimplifiedD = D div G,
    case SimplifiedD < 0 of
        true -> integer_to_binary(-SimplifiedN) ++ <<"/">> ++ integer_to_binary(-SimplifiedD);
        false -> integer_to_binary(SimplifiedN) ++ <<"/">> ++ integer_to_binary(SimplifiedD)
    end.