-module(solution).
-export([maximum_unique_subarray/1]).

maximum_unique_subarray(A) ->
    maximum_unique_subarray(A, [], 0, 0, dict:new()).

maximum_unique_subarray([], _, MaxSum, CurrSum, _) ->
    MaxSum;
maximum_unique_subarray([H | T], Visited, MaxSum, CurrSum, VisitedDict) ->
    case dict:find(H, VisitedDict) of
        {ok, _} ->
            % Remove elements from the start until H is unique
            {NewVisited, NewCurrSum, NewVisitedDict} = remove_until_unique(H, Visited, CurrSum, VisitedDict);
            maximum_unique_subarray(T, [H | NewVisited], max(MaxSum, NewCurrSum), NewCurrSum + H, dict:store(H, true, NewVisitedDict));
        _ ->
            maximum_unique_subarray(T, [H | Visited], max(MaxSum, CurrSum + H), CurrSum + H, dict:store(H, true, VisitedDict))
    end.

remove_until_unique(H, [X | Rest], CurrSum, VisitedDict) ->
    NewCurrSum = CurrSum - X,
    NewVisitedDict = dict:erase(X, VisitedDict),
    if
        X =:= H -> {Rest, NewCurrSum, NewVisitedDict};
        true -> remove_until_unique(H, Rest, NewCurrSum, NewVisitedDict)
    end.