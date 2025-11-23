-module(valid_parentheses).
-export([canBeValid/2]).

canBeValid(S, Locked) ->
    canBeValid(S, Locked, 0, 0).

canBeValid([], [], Open, Flexible) ->
    Open =< Flexible;
canBeValid([H|T], [L|LT], Open, Flexible) ->
    case L of
        $0 ->
            canBeValid(T, LT, Open, Flexible + 1);
        $1 ->
            case H of
                $( ->
                    canBeValid(T, LT, Open + 1, Flexible);
                $) ->
                    case Open > 0 of
                        true ->
                            canBeValid(T, LT, Open - 1, Flexible);
                        false ->
                            case Flexible > 0 of
                                true ->
                                    canBeValid(T, LT, Open, Flexible - 1);
                                false ->
                                    false
                            end
                    end
            end
    end.

canBeValid(S, Locked) when length(S) rem 2 /= 0 ->
    false;
canBeValid(S, Locked) ->
    Forward = canBeValidForward(S, Locked, 0, 0),
    Reverse = canBeValidReverse(S, Locked, 0, 0),
    Forward and Reverse.

canBeValidForward([], [], Open, Flexible) ->
    Open =< Flexible;
canBeValidForward([H|T], [L|LT], Open, Flexible) ->
    case L of
        $0 ->
            canBeValidForward(T, LT, Open, Flexible + 1);
        $1 ->
            case H of
                $( ->
                    canBeValidForward(T, LT, Open + 1, Flexible);
                $) ->
                    case Open > 0 of
                        true ->
                            canBeValidForward(T, LT, Open - 1, Flexible);
                        false ->
                            case Flexible > 0 of
                                true ->
                                    canBeValidForward(T, LT, Open, Flexible - 1);
                                false ->
                                    false
                            end
                    end
            end
    end.

canBeValidReverse([], [], Open, Flexible) ->
    Open =< Flexible;
canBeValidReverse([H|T], [L|LT], Open, Flexible) ->
    case L of
        $0 ->
            canBeValidReverse(T, LT, Open, Flexible + 1);
        $1 ->
            case H of
                $) ->
                    canBeValidReverse(T, LT, Open + 1, Flexible);
                $( ->
                    case Open > 0 of
                        true ->
                            canBeValidReverse(T, LT, Open - 1, Flexible);
                        false ->
                            case Flexible > 0 of
                                true ->
                                    canBeValidReverse(T, LT, Open, Flexible - 1);
                                false ->
                                    false
                            end
                    end
            end
    end.

canBeValidForward(S, Locked, Open, Flexible) when Open + Flexible < 0 -> false.
canBeValidReverse(S, Locked, Open, Flexible) when Open + Flexible < 0 -> false.

canBeValidForward(S, Locked, Open, Flexible) ->
    canBeValidForward(S, Locked, Open, Flexible, 0).

canBeValidReverse(S, Locked, Open, Flexible) ->
    canBeValidReverse(S, Locked, Open, Flexible, 0).

canBeValidForward([], [], Open, Flexible, Count) ->
    (Open - Flexible) =< 0;
canBeValidForward([H|T], [L|LT], Open, Flexible, Count) ->
    case L of
        $0 ->
            canBeValidForward(T, LT, Open, Flexible + 1, Count + 1);
        $1 ->
            case H of
                $( ->
                    canBeValidForward(T, LT, Open + 1, Flexible, Count + 1);
                $) ->
                    case Open > 0 of
                        true ->
                            canBeValidForward(T, LT, Open - 1, Flexible, Count + 1);
                        false ->
                            case Flexible > 0 of
                                true ->
                                    canBeValidForward(T, LT, Open, Flexible - 1, Count + 1);
                                false ->
                                    false
                            end
                    end
            end
    end.

canBeValidReverse([], [], Open, Flexible, Count) ->
    (Open - Flexible) =< 0;
canBeValidReverse([H|T], [L|LT], Open, Flexible, Count) ->
    case L of
        $0 ->
            canBeValidReverse(T, LT, Open, Flexible + 1, Count + 1);
        $1 ->
            case H of
                $) ->
                    canBeValidReverse(T, LT, Open + 1, Flexible, Count + 1);
                $( ->
                    case Open > 0 of
                        true ->
                            canBeValidReverse(T, LT, Open - 1, Flexible, Count + 1);
                        false ->
                            case Flexible > 0 of
                                true ->
                                    canBeValidReverse(T, LT, Open, Flexible - 1, Count + 1);
                                false ->
                                    false
                            end
                    end
            end
    end.