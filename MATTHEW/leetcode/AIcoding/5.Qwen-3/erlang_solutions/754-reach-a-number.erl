-module(reach_a_number).
-export([reach/1]).

reach(N) ->
    reach(N, 1, 1).

reach(N, Step, Sum) ->
    if
        Sum == N -> Step;
        Sum > N -> 
            case (Sum - N) rem 2 of
                0 -> Step;
                _ -> reach(N, Step + 1, Sum + Step + 1)
            end;
        true -> reach(N, Step + 1, Sum + Step + 1)
    end.