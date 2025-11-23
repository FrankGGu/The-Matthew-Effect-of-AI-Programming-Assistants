-module(solution).
-export([reach_number/1]).

reach_number(N) when N < 0 -> reach_number(-N);
reach_number(N) -> reach_number_helper(N, 0, 0).

reach_number_helper(Target, Sum, Step) ->
    if
        Sum =:= Target -> Step;
        Sum > Target, (Sum - Target) rem 2 =:= 0 -> Step;
        true -> reach_number_helper(Target, Sum + Step + 1, Step + 1)
    end.