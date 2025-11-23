-module(solution).
-export([check_record/1]).

check_record(Record) ->
    case string:foldl(fun(C, Acc) ->
        case Acc of
            {_, 2} -> {true, 2};
            {_, A} when C == $A -> {true, A + 1};
            {_, A} -> {false, A}
        end
    end, {false, 0}, Record) of
        {true, _} -> false;
        {false, A} when A >= 2 -> false;
        _ -> true
    end.