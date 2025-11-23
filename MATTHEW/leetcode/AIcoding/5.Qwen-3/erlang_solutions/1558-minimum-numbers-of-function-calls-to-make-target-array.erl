-module(solution).
-export([num_calls/1]).

num_calls(Target) ->
    num_calls(Target, 0).

num_calls([], _Count) ->
    _Count;
num_calls([H | T], Count) ->
    case H of
        0 ->
            num_calls(T, Count);
        _ ->
            case H rem 2 of
                0 ->
                    num_calls([H div 2 | T], Count + 1);
                1 ->
                    num_calls([H - 1 | T], Count + 1)
            end
    end.