-module(remove_zero_sum).
-export([remove_zero_sum/1]).

remove_zero_sum(Head) ->
    remove_zero_sum_helper(Head, []).

remove_zero_sum_helper(null, _) ->
    null;
remove_zero_sum_helper(Head, Seen) ->
    Val = list_to_integer(element(1,Head)),

    case lists:member({Val, Head}, Seen) of
        true ->
            null;
        false ->
            case sum_from_node(Head) of
                0 ->
                    remove_zero_sum_helper(element(2,Head), []);
                _ ->
                Tail = remove_zero_sum_helper(element(2,Head), [{Val+sum_from_head_to_here(Head, Seen),Head}|Seen]),
                list_to_tuple([list_to_binary(integer_to_list(Val)),Tail])

            end
    end.

sum_from_head_to_here(Head,Seen) ->
    sum_from_head_to_here_helper(Head,Seen,0).

sum_from_head_to_here_helper(_,[],Sum) ->
    Sum;
sum_from_head_to_here_helper(Head,[{Val,Node}|Rest],Sum) ->
    if Head == Node ->
        Sum+Val;
    true ->
        sum_from_head_to_here_helper(Head,Rest,Sum+Val)
    end.

sum_from_node(null) ->
    0;
sum_from_node(Head) ->
    sum_from_node_helper(Head,0).

sum_from_node_helper(null,Sum) ->
    Sum;
sum_from_node_helper(Head,Sum) ->
    Val = list_to_integer(element(1,Head)),
    sum_from_node_helper(element(2,Head),Sum+Val).