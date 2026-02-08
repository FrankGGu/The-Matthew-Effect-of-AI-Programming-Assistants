-module(solution).
-export([find_error_nums/1]).

find_error_nums(Numbers) ->
    N = length(Numbers),
    List = lists:seq(1, N),
    {Missing, Duplicate} = find_error(List, Numbers, #{}, #{}, 1, N),
    {Duplicate, Missing}.

find_error([], _, Seen, _, _, _) -> {undefined, undefined};
find_error([H | T], Numbers, Seen, Count, I, N) ->
    case maps:is_key(H, Seen) of
        true -> 
            find_error(T, Numbers, Seen, Count, I, N);
        false ->
            case lists:member(H, Numbers) of
                true -> 
                    find_error(T, Numbers, maps:put(H, true, Seen), Count, I + 1, N);
                false -> 
                    find_error(T, Numbers, Seen, H, I + 1, N)
            end
    end.