-spec powerful_integers(X :: integer(), Y :: integer(), Bound :: integer()) -> [integer()].
powerful_integers(X, Y, Bound) ->
    powerful_integers(X, Y, Bound, sets:new()).

powerful_integers(X, Y, Bound, Set) ->
    MaxI = if X =:= 1 -> 0; true -> trunc(math:log(Bound) / math:log(X)) end,
    MaxJ = if Y =:= 1 -> 0; true -> trunc(math:log(Bound) / math:log(Y)) end,
    lists:usort(
        lists:flatten(
            [[begin
                  Val = pow(X, I) + pow(Y, J),
                  if Val =< Bound -> [Val]; true -> [] end
              end || J <- lists:seq(0, MaxJ + 1)]
            || I <- lists:seq(0, MaxI + 1)]
        )).

pow(_, 0) -> 1;
pow(1, _) -> 1;
pow(X, I) -> pow(X, I, 1).

pow(_, 0, Acc) -> Acc;
pow(X, I, Acc) -> pow(X, I - 1, Acc * X).