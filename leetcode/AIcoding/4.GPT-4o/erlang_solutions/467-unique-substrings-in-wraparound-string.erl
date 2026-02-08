-module(solution).
-export([find_substring_in_wrapround_string/1]).

-spec find_substring_in_wrapround_string(unicode:unicode_binary()) -> integer().
find_substring_in_wrapround_string(S) ->
    find_substring_in_wrapround_string(S, 0, <<>>).

-spec find_substring_in_wrapround_string(unicode:unicode_binary(), integer(), unicode:unicode_binary()) -> integer().
find_substring_in_wrapround_string(<<>>, Count, _) -> Count;
find_substring_in_wrapround_string(S, Count, Prev) ->
    case unicode:characters_to_binary(Prev) of
        <<>> -> find_substring_in_wrapround_string(tl(S), Count, hd(S));
        _ -> 
            find_substring_in_wrapround_string(tl(S), Count, hd(S)) ;
        end.
