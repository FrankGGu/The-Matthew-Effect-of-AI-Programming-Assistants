-spec nth_ugly_number(N :: integer()) -> integer().
nth_ugly_number(N) ->
    UglyNumbers = [1],
    nth_ugly_number(N, UglyNumbers).

nth_ugly_number(1, [H | _]) -> H;
nth_ugly_number(N, UglyNumbers) ->
    NextUgly = min(min(2 * hd(UglyNumbers), 3 * hd(UglyNumbers)), 5 * hd(UglyNumbers)),
    nth_ugly_number(N - 1, [NextUgly | UglyNumbers]).
