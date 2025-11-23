-module(solution).
-export([findDuplicate/1]).

findDuplicate(Paths) ->
    ContentMap = lists:foldl(
        fun(PathString, AccMap) ->
            [Directory | FileStrings] = string:split(PathString, " ", [global]),

            lists:foldl(
                fun(FileString, InnerAccMap) ->
                    OpenParenIndex = string:find(FileString, "("),
                    FileName = string:substr(FileString, 1, OpenParenIndex - 1),
                    ContentWithParens = string:substr(FileString, OpenParenIndex),
                    FileContent = string:substr(ContentWithParens, 2, length(ContentWithParens) - 2),

                    FullPath = Directory ++ "/" ++ FileName,

                    maps:update_with(FileContent, fun(ExistingPaths) -> [FullPath | ExistingPaths] end, [FullPath], InnerAccMap)
                end,
                AccMap,
                FileStrings
            )
        end,
        maps:new(),
        Paths
    ),

    lists:filter(fun(Group) -> length(Group) > 1 end, maps:values(ContentMap)).