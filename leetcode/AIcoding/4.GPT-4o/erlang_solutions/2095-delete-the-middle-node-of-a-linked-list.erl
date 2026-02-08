-module(solution).
-export([delete_middle/1]).

-type node() :: {value, node()} | null.

delete_middle(Head) ->
    case delete_middle_helper(Head, 0, get_length(Head)) of
        {ok, NewHead} -> NewHead;
        error -> null
    end.

delete_middle_helper(null, _, _) -> {ok, null};
delete_middle_helper(Head, Index, Length) when Length =< 0 -> {ok, Head};
delete_middle_helper({Value, Next}, Index, Length) ->
    if
        Index =:= Length div 2 -> {ok, Next}; 
        true -> 
            case delete_middle_helper(Next, Index + 1, Length) of
                {ok, NewNext} -> {ok, {Value, NewNext}};
                error -> error
            end
    end.

get_length(Head) ->
    get_length_helper(Head, 0).

get_length_helper(null, Acc) -> Acc;
get_length_helper({_Value, Next}, Acc) -> get_length_helper(Next, Acc + 1).