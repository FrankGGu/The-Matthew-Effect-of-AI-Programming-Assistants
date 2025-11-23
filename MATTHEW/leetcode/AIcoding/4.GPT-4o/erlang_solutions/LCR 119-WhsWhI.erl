-module(solution).
-export([longest_consecutive/1]).

longest_consecutive(Numbers) ->
    Sets = sets:from_list(Numbers),
    longest_consecutive_helper(Sets, sets:to_list(Sets), 0).

longest_consecutive_helper(_, [], Max) ->
    Max;
longest_consecutive_helper(Sets, [H | T], Max) ->
    case sets:is_element(H, Sets) of
        false -> longest_consecutive_helper(Sets, T, Max);
        true ->
            {Len, Next} = count_length(Sets, H, 1),
            longest_consecutive_helper(Sets, Next, max(Max, Len))
    end.

count_length(Sets, Current, Length) ->
    Next = Current + 1,
    case sets:is_element(Next, Sets) of
        true -> count_length(Sets, Next, Length + 1);
        false -> {Length, Current + 1}
    end.