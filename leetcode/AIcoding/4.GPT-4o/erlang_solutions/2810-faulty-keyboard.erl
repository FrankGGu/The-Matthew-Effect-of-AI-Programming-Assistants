-module(solution).
-export([final_string/1]).

final_string(S) ->
    final_string(S, []).

final_string([], Acc) ->
    lists:reverse(Acc);
final_string([H | T], Acc) ->
    case H of
        $# -> final_string(T, tl(Acc));
        _ -> final_string(T, [H | Acc])
    end.