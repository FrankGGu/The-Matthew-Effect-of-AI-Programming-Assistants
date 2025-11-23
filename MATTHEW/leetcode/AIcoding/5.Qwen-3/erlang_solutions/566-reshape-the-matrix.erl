-module(solution).
-export([reshape/2]).

reshape(Mat, R) ->
    flatten(Mat, []),
    [H|T] = lists:flatten(Mat),
    reshape_helper(H, T, R, []).

flatten([], Acc) ->
    Acc;
flatten([H|T], Acc) ->
    flatten(T, Acc ++ H).

reshape_helper(_, [], _, Result) ->
    Result;
reshape_helper(_, _, 0, _) ->
    [];
reshape_helper(Val, Rest, R, Result) ->
    case length(Result) of
        Len when Len == R ->
            reshape_helper(Val, Rest, R, []);
        _ ->
            case length(Result) of
                Len ->
                    NewResult = Result ++ [[Val]],
                    reshape_helper(hd(Rest), tl(Rest), R, NewResult)
            end
    end.