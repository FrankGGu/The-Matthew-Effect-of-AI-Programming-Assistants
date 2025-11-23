-module(solution).
-export([findLongestWord/2]).

findLongestWord(S, D) ->
    lists:foldl(fun(Word, Acc) ->
                    case is_subsequence(Word, S) of
                        true ->
                            case {length(Word), length(Acc)} of
                                {LenW, LenAcc} when LenW > LenAcc ->
                                    Word;
                                {LenW, LenAcc} when LenW == LenAcc ->
                                    case Word < Acc of
                                        true -> Word;
                                        false -> Acc
                                    end;
                                _ ->
                                    Acc
                            end;
                        false ->
                            Acc
                    end
                end, [], D).

is_subsequence([], _S) -> true;
is_subsequence(_W, []) -> false;
is_subsequence([HW|TW], [HS|TS]) when HW == HS -> is_subsequence(TW, TS);
is_subsequence([HW|TW], [_HS|TS]) -> is_subsequence([HW|TW], TS).