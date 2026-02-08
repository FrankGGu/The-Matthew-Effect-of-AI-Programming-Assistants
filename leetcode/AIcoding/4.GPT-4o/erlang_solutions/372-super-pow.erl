-spec super_pow(A :: integer(), B :: [integer()]) -> integer().
super_pow(A, B) ->
    super_pow(A rem 1337, B, 1).

super_pow(_, [], Result) -> Result;
super_pow(A, [H | T], Result) ->
    NewResult = (Result * (A^H rem 1337)) rem 1337,
    super_pow(A^10 rem 1337, T, NewResult).
