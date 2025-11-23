-module(solution).
-export([check_valid/1]).

check_valid(Matrix) ->
    N = length(Matrix),
    ExpectedNumbers = lists:seq(1, N),
    ExpectedSet = sets:from_list(ExpectedNumbers),

    case check_all_lists(Matrix, ExpectedSet) of
        true ->
            TransposedMatrix = transpose(Matrix),
            check_all_lists(TransposedMatrix, ExpectedSet);
        false ->
            false
    end.

check_all_lists([], _ExpectedSet) ->
    true;
check_all_lists([List | Rest], ExpectedSet) ->
    ListSet = sets:from_list(List),
    if sets:is_equal(ListSet, ExpectedSet) ->
        check_all_lists(Rest, ExpectedSet);
    true ->
        false
    end.

transpose([]) ->
    [];
transpose([[]|_]) ->
    [];
transpose(Matrix) ->
    [ [H || [H|_] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].