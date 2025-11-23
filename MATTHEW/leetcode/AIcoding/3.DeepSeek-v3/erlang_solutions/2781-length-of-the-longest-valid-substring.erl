-module(solution).
-export([longest_valid_substring/2]).

longest_valid_substring(Word, Forbidden) ->
    ForbiddenSet = sets:from_list(Forbidden),
    N = length(Word),
    MaxLen = 0,
    {Ans, _} = lists:foldl(
        fun(Char, {CurrentMax, CurrentLen}) ->
            NewLen = CurrentLen + 1,
            Substring = lists:sublist(Word, Char - NewLen + 1, NewLen),
            case sets:is_element(Substring, ForbiddenSet) of
                true ->
                    {CurrentMax, 0};
                false ->
                    NewMax = max(CurrentMax, NewLen),
                    {NewMax, NewLen}
            end
        end,
        {MaxLen, 0},
        lists:seq(1, N)
    ),
    Ans.