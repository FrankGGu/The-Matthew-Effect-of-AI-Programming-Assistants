%% -spec partition(S :: unicode:unicode_binary()) -> [[unicode:unicode_binary()]].
partition(S) ->
    partition(S, []).

partition(<<>>, Acc) -> [lists:reverse(Acc)];
partition(S, Acc) ->
    lists:foldl(fun(Part, Acc1) -> 
        case is_palindrome(Part) of
            true -> partition(lists:drop(length(Part), S), [Part | Acc1]);
            false -> Acc1
        end
    end, [], substrings(S)).

%% Helper function to check if a string is a palindrome.
-spec is_palindrome(Part :: unicode:unicode_binary()) -> boolean().
is_palindrome(Part) -> 
    Part == lists:reverse(Part).

%% Generate all substrings of a string.
-spec substrings(S :: unicode:unicode_binary()) -> [[unicode:unicode_binary()]].
substrings(S) -> 
    substrings(S, length(S)).

substrings(_, 0) -> [];
substrings(S, N) -> 
    [<<S/binary:1:N>> | substrings(S, N - 1)].
