-module(solution).
-export([findDuplicateFiles/1]).

findDuplicateFiles(Paths) ->
    lists:foldl(fun(Path, Acc) ->
        find_files(Path, Acc)
    end, #{}, Paths).

find_files(Path, Acc) ->
    {ok, Files} = file:list_dir(Path),
    lists:foldl(fun(File, Acc) ->
        FullPath = filename:join(Path, File),
        case file:read_file(FullPath) of
            {ok, Content} ->
                Hash = crypto:hash(sha, Content),
                Map = maps:update_with(Hash, fun(L) -> [FullPath | L] end, [FullPath], Acc),
                Map;
            _ ->
                Acc
        end
    end, Acc, Files).

:- application(start/0).

start() ->
    {ok, _} = application:start(crypto).