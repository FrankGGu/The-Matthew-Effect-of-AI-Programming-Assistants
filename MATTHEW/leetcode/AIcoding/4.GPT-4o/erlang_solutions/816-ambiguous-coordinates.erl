-module(solution).
-export([ambiguous_coordinates/1]).

ambiguous_coordinates(S) ->
    S1 = string:trim(S, "{}"),
    Numbers = string:tokens(S1, ","),
    A = list_to_integer(hd(Numbers)),
    B = list_to_integer(hd(tl(Numbers))),
    CoordinatesA = generate_coordinates(A),
    CoordinatesB = generate_coordinates(B),
    lists:flatmap(fun(X) -> 
        lists:map(fun(Y) -> "(" ++ X ++ ", " ++ Y ++ ")" end, CoordinatesB) 
    end, CoordinatesA).

generate_coordinates(0) -> 
    ["0"];
generate_coordinates(N) -> 
    NumStr = integer_to_list(N),
    Length = length(NumStr),
    lists:foldl(fun(I, Acc) -> 
        if 
            I == 0 -> Acc; 
            true -> 
                Prefix = string:substring(NumStr, 0, I),
                Suffix = string:substring(NumStr, I, Length - I),
                NewCoords = case Suffix of
                    "" -> [Prefix];
                    _ -> [Prefix ++ "." ++ Suffix]
                end,
                Acc ++ NewCoords
        end 
    end, [], lists:seq(0, Length)).