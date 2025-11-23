-module(solution).
-export([simplifyPath/1]).

simplifyPath(Path) ->
    Parts = string:tokens(Path, "/"),
    Stack = lists:foldl(fun(Part, AccStack) ->
                                case Part of
                                    "." -> AccStack;
                                    ".." ->
                                        case AccStack of
                                            [] -> AccStack;
                                            [_|T] -> T
                                        end;
                                    _ -> [Part|AccStack]
                                end
                        end, [], Parts),

    SimplifiedParts = lists:reverse(Stack),

    case SimplifiedParts of
        [] -> "/";
        _ -> "/" ++ string:join(SimplifiedParts, "/")
    end.