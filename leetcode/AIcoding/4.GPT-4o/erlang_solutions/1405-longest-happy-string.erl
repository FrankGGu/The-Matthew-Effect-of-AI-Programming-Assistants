-module(solution).
-export([longest_happy_string/3]).

longest_happy_string(A, B, C) ->
    MaxList = lists:max([A, B, C]),
    loop(A, B, C, MaxList, []).

loop(0, 0, 0, _, Acc) -> 
    lists:reverse(Acc);
loop(A, B, C, Max, Acc) ->
    case Max of
        _ when A >= B, A >= C -> 
            case Acc of
                [] -> loop(A - 1, B, C, Max - 1, [<<"a">> | Acc]);
                [H | _] when H =:= <<"a">> -> 
                    case B > 0 -> loop(A, B - 1, C, Max, [<<"b">> | Acc]);
                    C > 0 -> loop(A, B, C - 1, Max, [<<"c">> | Acc])
                    end;
                _ -> loop(A - 1, B, C, Max - 1, [<<"a">> | Acc])
            end;
        _ when B >= A, B >= C -> 
            case Acc of
                [] -> loop(A, B - 1, C, Max - 1, [<<"b">> | Acc]);
                [H | _] when H =:= <<"b">> -> 
                    case A > 0 -> loop(A - 1, B, C, Max, [<<"a">> | Acc]);
                    C > 0 -> loop(A, B, C - 1, Max, [<<"c">> | Acc])
                    end;
                _ -> loop(A, B - 1, C, Max - 1, [<<"b">> | Acc])
            end;
        _ -> 
            case Acc of
                [] -> loop(A, B, C - 1, Max - 1, [<<"c">> | Acc]);
                [H | _] when H =:= <<"c">> -> 
                    case A > 0 -> loop(A - 1, B, C, Max, [<<"a">> | Acc]);
                    B > 0 -> loop(A, B - 1, C, Max, [<<"b">> | Acc])
                    end;
                _ -> loop(A, B, C - 1, Max - 1, [<<"c">> | Acc])
            end
    end.