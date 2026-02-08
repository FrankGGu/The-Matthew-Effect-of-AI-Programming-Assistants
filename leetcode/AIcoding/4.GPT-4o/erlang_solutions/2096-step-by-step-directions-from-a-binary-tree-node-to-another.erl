-module(solution).
-export([get_directions/3]).

get_directions(Root, Start, Dest) ->
    PathToStart = find_path(Root, Start, []),
    PathToDest = find_path(Root, Dest, []),
    {Up, Down} = split_paths(PathToStart, PathToDest),
    lists:duplicate(length(Up), 'U') ++ Down.

find_path(nil, _, _) -> [];
find_path(Node, Value, Visited) ->
    case Node of
        {Value, _, _} -> [Node];
        {_, Left, Right} ->
            if
                lists:member(Node, Visited) -> [];
                true ->
                    Visited1 = [Node | Visited],
                    case find_path(Left, Value, Visited1) of
                        [] -> find_path(Right, Value, Visited1);
                        Path -> Path
                    end
            end
    end.

split_paths([], DestPath) -> {[], DestPath};
split_paths(StartPath, DestPath) ->
    case lists:reverse(StartPath) of
        [] -> {lists:reverse(StartPath), lists:reverse(DestPath)};
        [H | T] ->
            case lists:member(H, DestPath) of
                true -> {lists:reverse(T), lists:reverse(DestPath)};
                false -> split_paths(T, DestPath)
            end
    end.