-module(original_string).
-export([is_original_text/2]).

is_original_text(S1, S2) ->
    Len1 = length(S1),
    Len2 = length(S2),
    memo(S1, S2, 0, 0, Len1, Len2, #{}).

memo(_S1, _S2, I, J, Len1, Len2, Memo) when I == Len1 and J == Len2 ->
    true;
memo(_S1, _S2, I, _J, Len1, _Len2, _Memo) when I == Len1 ->
    false;
memo(_S1, _S2, _I, J, _Len1, Len2, _Memo) when J == Len2 ->
    false;
memo(S1, S2, I, J, Len1, Len2, Memo) ->
    case maps:get({I, J}, Memo, undefined) of
        undefined ->
            Result = 
                case (is_digit(S1, I) andalso is_digit(S2, J)) of
                    true ->
                        case (parse_number(S1, I) == parse_number(S2, J)) of
                            true ->
                                memo(S1, S2, I + number_length(S1, I), J + number_length(S2, J), Len1, Len2, maps:put({I, J}, true, Memo));
                            false ->
                                false
                        end;
                    false ->
                        case (is_digit(S1, I)) of
                            true ->
                                Num1 = parse_number(S1, I),
                                Sub1 = sub_string(S2, J, 1),
                                case (Num1 == string:len(Sub1)) of
                                    true ->
                                        memo(S1, S2, I + number_length(S1, I), J + Num1, Len1, Len2, maps:put({I, J}, true, Memo));
                                    false ->
                                        case (Num1 > string:len(sub_string(S2, J, Len2-J))) of
                                            true ->
                                                false;
                                            false ->
                                                false
                                        end
                                end;
                            false ->
                                case (is_digit(S2, J)) of
                                    true ->
                                        Num2 = parse_number(S2, J),
                                        Sub2 = sub_string(S1, I, 1),
                                        case (Num2 == string:len(Sub2)) of
                                            true ->
                                                memo(S1, S2, I + Num2, J + number_length(S2, J), Len1, Len2, maps:put({I, J}, true, Memo));
                                            false ->
                                                case (Num2 > string:len(sub_string(S1, I, Len1-I))) of
                                                    true ->
                                                        false;
                                                    false ->
                                                        false
                                                end
                                        end;
                                    false ->
                                        case (string:at(S1, I+1) == string:at(S2, J+1)) of
                                            true ->
                                                memo(S1, S2, I + 1, J + 1, Len1, Len2, maps:put({I, J}, true, Memo));
                                            false ->
                                                false
                                        end
                                end
                        end
                end,
            maps:get({I,J},case Result of
                              true ->
                                  Memo = maps:put({I,J},true,Memo);
                              false ->
                                  Memo
                          end)
        ;
        true ->
            true
    end.

is_digit(S, I) ->
    case (catch erlang:list_to_integer(string:substr(S, I+1, 1))) of
        _Error ->
            false;
        _ ->
            case (string:at(S,I+1) =/= "0") of
                true ->
                    true;
                false ->
                    case (I+1 < length(S)) of
                        true ->
                            case (catch erlang:list_to_integer(string:substr(S, I+2, 1))) of
                                _Error ->
                                    false;
                                _ ->
                                    true
                            end;
                        false ->
                            false
                    end
            end
    end.

parse_number(S, I) ->
    parse_number_helper(S, I, 0).

parse_number_helper(S, I, Acc) ->
    try
        Digit = erlang:list_to_integer(string:substr(S, I+1, 1)),
        parse_number_helper(S, I + 1, Acc * 10 + Digit)
    catch
        _:_ ->
            Acc
    end.

number_length(S, I) ->
    number_length_helper(S, I, 0).

number_length_helper(S, I, Len) ->
    try
        erlang:list_to_integer(string:substr(S, I+1, 1)),
        number_length_helper(S, I + 1, Len + 1)
    catch
        _:_ ->
            Len
    end.