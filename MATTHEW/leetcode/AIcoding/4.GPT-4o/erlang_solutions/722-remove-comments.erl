-module(solution).
-export([remove_comments/1]).

remove_comments(Source) ->
    remove_comments(Source, [], false).

remove_comments([], Acc, _) ->
    lists:reverse(Acc);
remove_comments([H | T], Acc, InBlock) ->
    case {H, InBlock} of
        {"/", false} -> remove_comments(T, Acc, check_block_comment(T));
        {"/", true} -> remove_comments(T, Acc, true);
        {"*", false} -> remove_comments(T, Acc, true);
        {"*", true} -> remove_comments(T, Acc, false);
        {_, false} -> remove_comments(T, [H | Acc], false);
        {_, true} -> remove_comments(T, Acc, true)
    end.

check_block_comment([]) -> false;
check_block_comment([H | T]) ->
    case H of
        {"*", _} -> true;
        _ -> check_block_comment(T)
    end.