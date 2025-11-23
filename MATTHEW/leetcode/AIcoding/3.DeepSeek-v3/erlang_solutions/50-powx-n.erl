-spec my_pow(X :: float(), N :: integer()) -> float().
my_pow(X, N) when N >= 0 ->
    pow(X, N);
my_pow(X, N) ->
    1.0 / pow(X, -N).

pow(_, 0) ->
    1.0;
pow(X, N) when N rem 2 =:= 0 ->
    Half = pow(X, N div 2),
    Half * Half;
pow(X, N) ->
    Half = pow(X, N div 2),
    Half * Half * X.