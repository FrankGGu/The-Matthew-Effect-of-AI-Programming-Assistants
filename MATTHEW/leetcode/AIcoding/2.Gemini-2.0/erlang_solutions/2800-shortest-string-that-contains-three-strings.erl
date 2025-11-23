-module(shortest_string_three_strings).
-export([shortest_superstring/3]).

shortest_superstring(S1, S2, S3) ->
    lists:min([
        shortest_superstring_helper(S1, S2, S3),
        shortest_superstring_helper(S1, S3, S2),
        shortest_superstring_helper(S2, S1, S3),
        shortest_superstring_helper(S2, S3, S1),
        shortest_superstring_helper(S3, S1, S2),
        shortest_superstring_helper(S3, S2, S1)
    ]).

shortest_superstring_helper(S1, S2, S3) ->
    SS12 = merge(S1, S2),
    SS123 = merge(SS12, S3),
    SS123.

merge(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    for(I, 0, Len1 - 1,
        (fun(I) ->
            Overlap = min(Len1 - I, Len2),
            if
                string:substr(S1, I + 1, Overlap) == string:substr(S2, 1, Overlap) ->
                    {value, string:concat(S1, string:substr(S2, Overlap + 1, Len2 - Overlap))};
                true ->
                    skip
            end
        end));
    string:concat(S1, S2).

for(Var, Start, End, Fun) ->
    for(Var, Start, End, [], Fun).

for(Var, Start, End, Acc, Fun) when Start > End ->
    lists:reverse(Acc);
for(Var, Start, End, Acc, Fun) ->
    case Fun(Start) of
        skip ->
            for(Var, Start + 1, End, Acc, Fun);
        {value, Val} ->
            Val
    end.