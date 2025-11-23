-module(solution).
-export([remove_duplicates/1]).

remove_duplicates(Nums) ->
    remove_duplicates_impl(Nums, []).

remove_duplicates_impl([], Acc) ->
    length(Acc);
remove_duplicates_impl([H|T], Acc) ->
    case Acc of
        [] ->
            % First element, always include
            remove_duplicates_impl(T, [H]);
        [Prev1] ->
            % Second element, always include
            remove_duplicates_impl(T, [H|Acc]);
        [Prev1, Prev2 | _] ->
            % Third element or more, check for duplicates
            if
                H == Prev1 andalso H == Prev2 ->
                    % Current element is the same as the last two, skip it
                    remove_duplicates_impl(T, Acc);
                true ->
                    % Current element is different, or only same as one previous, include it
                    remove_duplicates_impl(T, [H|Acc])
            end
    end.