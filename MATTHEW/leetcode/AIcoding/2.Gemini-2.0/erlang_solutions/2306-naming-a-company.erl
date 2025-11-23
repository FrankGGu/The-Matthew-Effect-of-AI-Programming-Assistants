-module(naming_a_company).
-export([number_of_distinct_names/1]).

number_of_distinct_names(Ideas) ->
    Grouped = lists:foldl(
        fun(Idea, Acc) ->
            [First | _] = string:split(Idea, "", all),
            lists:update_with(
                fun(S) -> S ++ [Idea] end,
                First,
                [Idea],
                Acc
            )
        end,
        dict:new(),
        Ideas
    ),
    FirstLetters = dict:to_list(Grouped),
    Len = length(FirstLetters),
    lists:foldl(
        fun({A, SetA}, Acc) ->
            lists:foldl(
                fun({B, SetB}, Acc2) ->
                    if A == B ->
                        Acc2
                    else
                        Intersection = sets:intersection(sets:from_list(SetA), sets:from_list(SetB)),
                        DiffA = length(SetA) - sets:size(Intersection),
                        DiffB = length(SetB) - sets:size(Intersection),
                        Acc2 + DiffA * DiffB * 2
                    end
                end,
                Acc,
                FirstLetters
            )
        end,
        0,
        FirstLetters
    ).