-module(solution).
-export([detectCapitalUse/1]).

-spec detectCapitalUse(Word :: [char()]) -> boolean().
detectCapitalUse(Word) ->
    case Word of
        [H | T] ->
            if erlang:is_upper(H) ->
                all_upper(T) orelse all_lower(T);
            erlang:is_lower(H) ->
                all_lower(T)
            end
    end.

all_upper([]) -> true;
all_upper([H | T]) ->
    erlang:is_upper(H) andalso all_upper(T).

all_lower([]) -> true;
all_lower([H | T]) ->
    erlang:is_lower(H) andalso all_lower(T).