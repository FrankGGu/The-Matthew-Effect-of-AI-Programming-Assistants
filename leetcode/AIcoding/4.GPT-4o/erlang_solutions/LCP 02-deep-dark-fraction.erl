-module(solution).
-export([deepDarkFraction/2]).

deepDarkFraction(N, K) ->
    {Numerator, Denominator} = helper(N, K, 1, 1, 0),
    {Numerator, Denominator}.

helper(_, 0, Numerator, Denominator, _) -> 
    {Numerator, Denominator};
helper(N, K, Numerator, Denominator, Depth) when Depth < K ->
    helper(N, K, Numerator * 2, Denominator * 2, Depth + 1);
helper(N, K, Numerator, Denominator, Depth) -> 
    helper(N - 1, K, Numerator * 2 + 1, Denominator * 2, Depth).