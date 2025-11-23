-module(solution).
-export([shortest_uncommon_substring/1]).

shortest_uncommon_substring(Queries) ->
    lists:foldl(fun(Q, Acc) -> 
        case find_shortest_uncommon_substring(Q, Queries) of
            [] -> Acc;
            Sub -> [Sub | Acc]
        end
    end, [], Queries).

find_shortest_uncommon_substring(Query, Queries) ->
    Lists = lists:map(fun(Q) -> string:split(Q, "") end, Queries),
    Lengths = lists:usort([length(Q) || Q <- Queries]),
    lists:foldl(fun(Len, Acc) ->
        case Acc of
            [] -> 
                Subs = generate_substrings(Query, Len),
                case find_uncommon(Subs, Lists) of
                    [] -> Acc;
                    S -> [S | Acc]
                end;
            _ -> Acc
        end
    end, [], Lengths).

generate_substrings(S, Len) ->
    generate_substrings(S, Len, 0, []).

generate_substrings(_, Len, Pos, Acc) when Pos + Len > length(S) -> Acc;
generate_substrings(S, Len, Pos, Acc) ->
    Sub = string:substr(S, Pos + 1, Len),
    generate_substrings(S, Len, Pos + 1, [Sub | Acc]).

find_uncommon(Subs, Lists) ->
    lists:foldl(fun(Sub, Acc) ->
        case lists:all(fun(List) -> not lists:member(Sub, List) end, Lists) of
            true -> [Sub | Acc];
            false -> Acc
        end
    end, [], Subs).