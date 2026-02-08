-module(solution).
-export([detect_capital_use/1]).

-spec detect_capital_use(unicode:unicode_binary()) -> boolean().
detect_capital_use(Word) ->
    case length(Word) of
        1 -> true;
        _ ->
            UppercaseCount = count_uppercase(Word),
            case UppercaseCount of
                0 -> true; % All lowercase
                N when N == length(Word) -> true; % All uppercase
                1 when is_uppercase(hd(Word)) -> true; % Only the first letter is uppercase
                _ -> false
            end
    end.

-spec count_uppercase([unicode:unicode_binary()]) -> integer().
count_uppercase([]) -> 0;
count_uppercase([H | T]) ->
    (if is_uppercase(H) -> 1; true -> 0 end) + count_uppercase(T).

-spec is_uppercase(unicode:unicode_binary()) -> boolean().
is_uppercase(Char) ->
    Char >= $A, Char =< $Z.
