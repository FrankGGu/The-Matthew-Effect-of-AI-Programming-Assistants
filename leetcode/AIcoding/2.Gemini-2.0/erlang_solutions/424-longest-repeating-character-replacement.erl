-module(longest_repeating_character_replacement).
-export([character_replacement/2]).

character_replacement(S, K) ->
    character_replacement(string:to_list(S), K, 0, 0, []).

character_replacement(S, K, Start, End, Counts) ->
    case End < length(S) of
        true ->
            Char = lists:nth(End + 1, S);
            NewCounts = update_counts(Char, Counts);
            MaxCount = max_count(NewCounts);
            Length = End - Start + 1;

            case Length - MaxCount =< K of
                true ->
                    character_replacement(S, K, Start, End + 1, NewCounts);
                false ->
                    CharToRemove = lists:nth(Start + 1, S);
                    ReducedCounts = remove_char(CharToRemove, NewCounts);
                    character_replacement(S, K, Start + 1, End + 1, ReducedCounts)
            end;
        false ->
            End - Start
    end.

update_counts(Char, Counts) ->
    case lists:keyfind(Char, 1, Counts) of
        false ->
            [{Char, 1} | Counts];
        {Char, Count} ->
            lists:keyreplace(Char, 1, Counts, {Char, Count + 1})
    end.

remove_char(Char, Counts) ->
    case lists:keyfind(Char, 1, Counts) of
        {Char, 1} ->
            lists:keydelete(Char, 1, Counts);
        {Char, Count} ->
            lists:keyreplace(Char, 1, Counts, {Char, Count - 1})
    end.

max_count(Counts) ->
    lists:foldl(fun({_, Count}, Acc) -> max(Count, Acc) end, 0, Counts).