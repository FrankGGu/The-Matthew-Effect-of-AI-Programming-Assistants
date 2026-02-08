-module(second_min_node).
-export([main/0, find_second_min/1]).

-include("leetcode.hrl").

main() ->
    io:format("~p~n", [find_second_min(#{val => 2, left => #{val => 2, left => #{val => 2, left => null, right => null}, right => #{val => 2, left => null, right => null}}, right => #{val => 5, left => null, right => null}})]).

find_second_min(null) -> null;
find_second_min(Node) ->
    Val = Node#tree.val,
    Left = Node#tree.left,
    Right = Node#tree.right,
    case Left of
        null ->
            case Right of
                null -> Val;
                _ -> Val
            end;
        _ ->
            case Right of
                null ->
                    case Left of
                        null -> Val;
                        _ -> Val
                    end;
                _ ->
                    LeftMin = find_second_min(Left),
                    RightMin = find_second_min(Right),
                    if
                        LeftMin == Val andalso RightMin == Val -> Val;
                        LeftMin == Val -> RightMin;
                        RightMin == Val -> LeftMin;
                        true -> min(LeftMin, RightMin)
                    end
            end
    end.