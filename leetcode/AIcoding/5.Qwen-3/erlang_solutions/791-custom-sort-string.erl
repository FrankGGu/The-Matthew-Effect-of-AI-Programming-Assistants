-module(custom_sort_string).
-export([customSortString/2]).

customSortString(S, T) ->
    Map = maps:from_list([{C, I} || {I, C} <- lists:zip(lists:seq(0, length(S)-1), S)]),
    SortedT = lists:sort(fun(A, B) ->
        case maps:find(A, Map) of
            {ok, PosA} ->
                case maps:find(B, Map) of
                    {ok, PosB} -> PosA - PosB;
                    error -> 1
                end;
            error ->
                case maps:find(B, Map) of
                    {ok, PosB} -> -1;
                    error -> A - B
                end
        end
    end, T),
    lists:flatten(SortedT).