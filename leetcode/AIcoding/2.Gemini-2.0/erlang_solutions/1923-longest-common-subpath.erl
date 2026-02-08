-module(longest_common_subpath).
-export([longest_common_subpath/1]).

longest_common_subpath(paths) ->
    MinLen = lists:min([length(P) || P <- paths]),
    MaxLen = lists:max([length(P) || P <- paths]),

    case MinLen == 0 of
        true -> 0;
        false ->
            binary_search(1, MinLen, paths)
    end.

binary_search(Low, High, Paths) ->
    case Low > High of
        true -> High;
        false ->
            Mid = (Low + High + 1) div 2,
            case all_paths_contain_subpath(Mid, Paths) of
                true ->
                    binary_search(Mid, High, Paths);
                false ->
                    binary_search(Low, Mid - 1, Paths)
            end
    end.

all_paths_contain_subpath(Len, Paths) ->
    case Paths of
        [] -> true;
        [Path | Rest] ->
            HasSubpath = find_subpaths(Len, Path, Rest);
            HasSubpath andalso all_paths_contain_subpath(Len, Rest)
    end.

find_subpaths(Len, Path, Rest) ->
    Subpaths = get_all_subpaths(Len, Path),
    lists:all(fun(OtherPath) ->
                      lists:any(fun(Subpath) ->
                                        lists:sublist(OtherPath, 1, Len) == Subpath
                                end, Subpaths)
              end, Rest).

get_all_subpaths(Len, Path) ->
    LenPath = length(Path),
    [lists:sublist(Path, I, Len) || I <- lists:seq(1, LenPath - Len + 1)].