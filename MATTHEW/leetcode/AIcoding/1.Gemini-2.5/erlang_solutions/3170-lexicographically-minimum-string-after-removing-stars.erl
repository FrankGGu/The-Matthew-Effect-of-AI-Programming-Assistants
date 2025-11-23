-module(solution).
-export([minimum_string/1]).

minimum_string(S) ->
    InitialState = {0, gb_trees:empty()},

    {_FinalIndex, FinalTree} = lists:foldl(
        fun(CharOrStar, {CurrentIndex, AccTree}) ->
            if
                CharOrStar == $* ->
                    case gb_trees:is_empty(AccTree) of
                        true ->
                            {CurrentIndex + 1, AccTree};
                        false ->
                            KeyToRemove = gb_trees:smallest_key(AccTree),
                            {CurrentIndex + 1, gb_trees:delete(KeyToRemove, AccTree)}
                    end;
                true ->
                    Key = {-CharOrStar, -CurrentIndex},
                    {CurrentIndex + 1, gb_trees:insert(Key, CharOrStar, AccTree)}
            end
        end,
        InitialState,
        S
    ),

    ListOfKeyValues = gb_trees:to_list(FinalTree),

    ListOfIndexChars = lists:map(
        fun({{_NegChar, NegIndex}, Char}) ->
            {-NegIndex, Char}
        end,
        ListOfKeyValues
    ),

    SortedByIndex = lists:sort(
        fun({I1, _}, {I2, _}) -> I1 =< I2 end,
        ListOfIndexChars
    ),

    ResultChars = [Char || {_, Char} <- SortedByIndex],

    ResultChars.