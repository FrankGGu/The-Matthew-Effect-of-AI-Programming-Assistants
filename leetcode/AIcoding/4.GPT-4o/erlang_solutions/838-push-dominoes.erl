-module(solution).
-export([push_dominoes/1]).

push_dominoes(Dominoes) ->
    String = list_to_string(Dominoes),
    Result = push_dominoes_helper(String),
    string_to_list(Result).

push_dominoes_helper(Dominoes) ->
    NewDominoes = push_once(Dominoes),
    if
        NewDominoes =:= Dominoes -> Dominoes;
        true -> push_dominoes_helper(NewDominoes)
    end.

push_once(Dominoes) ->
    Length = string:length(Dominoes),
    lists:foldl(fun(Index, Acc) ->
        case string:substr(Acc, Index, 1) of
            "L" -> 
                if
                    Index > 1, string:substr(Acc, Index - 1, 1) =:= "R" -> 
                        string:substr(Acc, 1, Index - 2) ++ "L" ++ "R" ++ string:substr(Acc, Index + 1);
                    Index > 1, string:substr(Acc, Index - 1, 1) =:= "." -> 
                        string:substr(Acc, 1, Index - 1) ++ "L" ++ string:substr(Acc, Index + 1);
                    true -> Acc
                end;
            "R" -> 
                if
                    Index < Length, string:substr(Acc, Index + 1, 1) =:= "L" -> 
                        string:substr(Acc, 1, Index) ++ "R" ++ "L" ++ string:substr(Acc, Index + 2);
                    Index < Length, string:substr(Acc, Index + 1, 1) =:= "." -> 
                        string:substr(Acc, 1, Index) ++ "R" ++ string:substr(Acc, Index + 2);
                    true -> Acc
                end;
            _ -> Acc
        end
    end, Dominoes, Dominoes).