-module(remove_comments).
-export([remove_comments/1]).

remove_comments(Chars) ->
    remove_comments(Chars, [], false, false).

remove_comments([], Result, _, _) ->
    lists:reverse(Result);
remove_comments([$\n | Rest], Result, InBlock, InLine) ->
    remove_comments(Rest, [ $\n | Result ], InBlock, InLine);
remove_comments([$\* , $/ | Rest], Result, InBlock, InLine) ->
    if
        InBlock -> remove_comments(Rest, Result, false, InLine);
        true -> remove_comments(Rest, Result, true, InLine)
    end;
remove_comments([$// | Rest], Result, InBlock, InLine) ->
    if
        InBlock -> remove_comments(Rest, Result, InBlock, InLine);
        true -> remove_comments(Rest, Result, InBlock, true)
    end;
remove_comments([$* , $/ | Rest], Result, InBlock, InLine) ->
    if
        InBlock -> remove_comments(Rest, Result, false, InLine);
        true -> remove_comments(Rest, Result, InBlock, InLine)
    end;
remove_comments([$\\ , $/ | Rest], Result, InBlock, InLine) ->
    remove_comments(Rest, [ $\\ , $/ | Result ], InBlock, InLine);
remove_comments([C | Rest], Result, InBlock, InLine) ->
    if
        InBlock -> remove_comments(Rest, Result, InBlock, InLine);
        InLine -> remove_comments(Rest, Result, InBlock, InLine);
        true -> remove_comments(Rest, [ C | Result ], InBlock, InLine)
    end.