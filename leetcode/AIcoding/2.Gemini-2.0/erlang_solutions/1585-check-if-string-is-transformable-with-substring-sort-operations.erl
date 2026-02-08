-module(transformable_string).
-export([can_transform/2]).

can_transform(S, T) ->
    S_list = string:to_list(S),
    T_list = string:to_list(T),
    can_transform_helper(S_list, T_list, lists:seq(0, 9)).

can_transform_helper([], [], _) ->
    true;
can_transform_helper(_, [], _) ->
    false;
can_transform_helper(S_list, T_list, Digits) ->
    case T_list of
        [H | Rest_T] ->
            Digit = list_to_integer([H - $0]),
            case find_transformable(S_list, Digit, Digits) of
                {true, New_S_list} ->
                    can_transform_helper(New_S_list, Rest_T, Digits);
                false ->
                    false
            end
    end.

find_transformable(S_list, Digit, Digits) ->
    find_transformable_helper(S_list, Digit, Digits, []).

find_transformable_helper([], _, _, _) ->
    false;
find_transformable_helper([H | Rest_S], Digit, Digits, Acc) ->
    S_Digit = list_to_integer([H - $0]),
    case S_Digit of
        D when D =:= Digit ->
            {true, lists:reverse(Acc) ++ Rest_S};
        D when D < Digit ->
            find_transformable_helper(Rest_S, Digit, Digits, Acc ++ [H]);
        _ ->
            find_transformable_helper(Rest_S, Digit, Digits, Acc ++ [H])
    end.