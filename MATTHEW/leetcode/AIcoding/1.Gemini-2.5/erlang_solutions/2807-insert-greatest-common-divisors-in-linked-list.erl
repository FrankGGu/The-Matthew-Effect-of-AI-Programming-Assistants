-module(solution).
-export([insertGreatestCommonDivisors/1]).

insertGreatestCommonDivisors(nil) -> nil;
insertGreatestCommonDivisors({Val, nil}) -> {Val, nil};
insertGreatestCommonDivisors({Val1, {Val2, FurtherNextNode}}) ->
    GCD = math:gcd(Val1, Val2),
    NewNext = insertGreatestCommonDivisors({Val2, FurtherNextNode}),
    {Val1, {GCD, NewNext}}.