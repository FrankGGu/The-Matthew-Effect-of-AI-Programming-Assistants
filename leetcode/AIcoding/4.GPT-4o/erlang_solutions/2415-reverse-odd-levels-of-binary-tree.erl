-module(solution).
-export([reverseOddLevels/1]).

-record(node, {val, left = none, right = none}).

reverseOddLevels(Root) ->
    Levels = bfs([Root], 0, []),
    NewLevels = lists:map(fun(Level) -> 
        case Level of 
            [] -> []; 
            [_] -> Level; 
            _ -> lists:reverse(Level) 
        end 
    end, Levels),
    build_tree(NewLevels, 0).

bfs([], _, Acc) -> 
    lists:reverse(Acc);
bfs(Nodes, Level, Acc) -> 
    NextLevel = lists:flatmap(fun(Node) -> 
        case Node of 
            none -> []; 
            #node{left=Left, right=Right} -> [Left, Right] 
        end 
    end, Nodes),
    bfs(NextLevel, Level + 1, [lists:map(fun(Node) -> 
        case Node of 
            none -> undefined; 
            #node{val=Val} -> Val 
        end 
    end, Nodes) | Acc]).

build_tree([], _) -> 
    none;
build_tree([Level | Levels], LevelIndex) -> 
    NewNodes = lists:map(fun(Val) -> 
        case Val of 
            undefined -> none; 
            _ -> #node{val=Val} 
        end 
    end, Level),
    case LevelIndex rem 2 of 
        0 -> 
            lists:zipwith(fun(N, L) -> 
                case N of 
                    none -> none; 
                    #node{left=Left, right=Right} -> 
                        case L of 
                            none -> N; 
                            _ -> N#node{left=Left, right=Right} 
                        end 
                end 
            end, NewNodes, Levels);
        _ -> 
            lists:zipwith(fun(N, L) -> 
                case N of 
                    none -> none; 
                    #node{left=Left, right=Right} -> 
                        case L of 
                            none -> N; 
                            _ -> N#node{left=Left, right=Right} 
                        end 
                end 
            end, lists:reverse(NewNodes), Levels) 
    end.