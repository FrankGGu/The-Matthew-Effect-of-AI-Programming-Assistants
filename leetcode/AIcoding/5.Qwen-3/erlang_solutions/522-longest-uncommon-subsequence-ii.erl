-module(longest_uncommon_subsequence_ii).
-export([main/0]).

main() ->
    io:format("~p~n", [longest_uncommon_subsequence_ii(["aabbca", "bbaaac", "bbaaaab"])]).

longest_uncommon_subsequence_ii(Sts) ->
    lists:foldl(fun(S, Acc) -> 
        case is_uncommon(Sts, S) of
            true -> 
                if length(S) > length(Acc) -> S; true -> Acc end;
            false -> Acc
        end
    end, "", Sts).

is_uncommon(Sts, S) ->
    lists:all(fun(T) -> not is_subsequence(S, T) end, Sts).

is_subsequence([], _) -> true;
is_subsequence(_, []) -> false;
is_subsequence([H|T], [H|T2]) -> is_subsequence(T, T2);
is_subsequence([H|T], [_|T2]) -> is_subsequence([H|T], T2).