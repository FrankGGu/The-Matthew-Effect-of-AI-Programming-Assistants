-module(remove_one_element_to_make_the_array_strictly_increasing).
-export([canBeIncreasing/1]).

canBeIncreasing(Nums) ->
    canBeIncreasing(Nums, 0, false).

canBeIncreasing([], _, _) ->
    true;
canBeIncreasing([_], _, _) ->
    true;
canBeIncreasing([A, B | Rest], Count, Removed) ->
    if
        A < B ->
            canBeIncreasing([B | Rest], Count, Removed);
        true ->
            if
                Removed ->
                    false;
                true ->
                    if
                        Rest == [] ->
                            true;
                        true ->
                            [C | Rest2] = Rest,
                            if
                                A < C ->
                                    canBeIncreasing([C | Rest2], Count + 1, true);
                                true ->
                                    canBeIncreasing([A, C | Rest2], Count + 1, true)
                            end
                    end
            end
    end.