-module(solution).
-export([max_subsequences/2]).

max_subsequences(String, Subsequence) ->
    Count = string:to_lower(String),
    Sub = string:to_lower(Subsequence),
    LenSub = length(Sub),
    LenStr = length(Count),
    if
        LenSub > LenStr -> 0;
        true ->
            List = lists:seq(0, LenStr - 1),
            Indices = lists:foldl(fun(I, Acc) ->
                case lists:member(I, Acc) of
                    true -> Acc;
                    false ->
                        case check_subsequence(Count, Sub, I, 0, []) of
                            true -> [I | Acc];
                            false -> Acc
                        end
                end
            end, [], List),
            lists:foldl(fun(I, Acc) ->
                case check_subsequence(Count, Sub, I, 0, []) of
                    true -> Acc + 1;
                    false -> Acc
                end
            end, 0, Indices)
    end.

check_subsequence(_, [], _, _, _) -> true;
check_subsequence(_, _, _, _, _) -> false;
check_subsequence(Str, Sub, Pos, Index, Acc) ->
    case Index < length(Sub) of
        true ->
            Char = lists:nth(Index + 1, Sub),
            case find_char(Str, Char, Pos, []) of
                {ok, NewPos} ->
                    check_subsequence(Str, Sub, NewPos + 1, Index + 1, Acc);
                error ->
                    false
            end;
        false ->
            true
    end.

find_char(_, _, _, _) -> error;
find_char(Str, Char, Start, Acc) ->
    case Start < length(Str) of
        true ->
            if
                lists:nth(Start + 1, Str) == Char -> {ok, Start};
                true -> find_char(Str, Char, Start + 1, Acc)
            end;
        false ->
            error
    end.