-module(count_beautiful_numbers).
-export([countBeautifulNumbers/1]).

countBeautifulNumbers(N) ->
    string_to_integer(integer_to_list(N)),
    string_to_integer(integer_to_list(N)),
    count_beautiful_numbers_helper(N, 1).

count_beautiful_numbers_helper(N, Pos) ->
    case N of
        0 -> 0;
        _ ->
            Digit = N rem 10,
            Rest = N div 10,
            count_less_than_or_equal(Digit, Pos) +
            count_beautiful_numbers_helper(Rest, Pos + 1) * count_valid_choices(Pos)
            - count_overlap(N, Pos)
    end.

count_less_than_or_equal(Digit, Pos) ->
    case Pos of
        1 -> min(Digit, 9);
        2 -> min(Digit, 4);
        3 -> min(Digit, 2);
        4 -> min(Digit, 1);
        5 -> min(Digit, 1);
        6 -> min(Digit, 1);
        7 -> min(Digit, 1);
        8 -> min(Digit, 1);
        9 -> min(Digit, 1);
        _ -> 0
    end.

count_valid_choices(Pos) ->
    case Pos of
        1 -> 9;
        2 -> 5;
        3 -> 3;
        4 -> 2;
        5 -> 2;
        6 -> 2;
        7 -> 2;
        8 -> 2;
        9 -> 2;
        _ -> 0
    end.

count_overlap(N, Pos) ->
    case N of
        0 -> 0;
        _ ->
            Digit = N rem 10,
            Rest = N div 10,
            case Pos of
                1 ->
                    case Digit of
                        0 -> 0;
                        _ ->
                            case (Digit rem 2 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 5 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 2 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 2 == 1) of
                                true -> count_beautiful_numbers_helper(Rest, Pos + 1) * count_valid_choices(Pos) - count_overlap(Rest, Pos+1);
                                false -> 0
                            end
                    end;
                2 ->
                    case Digit of
                        0 -> 0;
                        _ ->
                            case (Digit rem 2 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 5 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 2 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 2 == 1) of
                                true -> count_beautiful_numbers_helper(Rest, Pos + 1) * count_valid_choices(Pos) - count_overlap(Rest, Pos+1);
                                false -> 0
                            end
                    end;
                3 ->
                     case Digit of
                        0 -> 0;
                        _ ->
                            case (Digit rem 2 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 5 == 1) orelse (Digit rem 5 == 0 andalso Pos rem 2 == 1) orelse (Digit rem 2 == 0 andalso Pos rem 3 == 1) orelse (Digit rem 3 == 0 andalso Pos rem 2 == 1) of
                                true -> count_beautiful_numbers_helper(Rest, Pos + 1) * count_valid_choices(Pos) - count_overlap(Rest, Pos+1);
                                false -> 0
                            end
                    end;
                _ -> 0
            end
    end.