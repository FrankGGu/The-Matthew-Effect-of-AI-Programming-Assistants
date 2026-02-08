-module(solution).
-export([check_ones/1]).

check_ones(<<>>) -> true;
check_ones(<<$0, Rest/binary>>) -> check_ones(Rest);
check_ones(<<$1, Rest/binary>>) ->
    case Rest of
        <<$1, _/binary>> -> false;
        _ -> check_ones(Rest)
    end.