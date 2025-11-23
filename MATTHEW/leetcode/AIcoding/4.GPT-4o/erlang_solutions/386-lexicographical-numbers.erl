-module(solution).
-compile([export_all]).

% Function to generate lexicographical numbers
lexical_order(N) -> lexical_order(N, 1, []).

% Recursive helper function
lexical_order(_, Current, Acc) when Current > N -> lists:reverse(Acc);
lexical_order(N, Current, Acc) ->
    lexical_order(N, Current * 10, [Current | Acc]);

% Function to step back to the next number in lexicographical order
lexical_order(N, Current, Acc) when Current >= N div 10 -> 
    lexical_order(N, Current + 1, Acc);
lexical_order(N, Current, Acc) -> 
    lexical_order(N, Current + 1, Acc).
