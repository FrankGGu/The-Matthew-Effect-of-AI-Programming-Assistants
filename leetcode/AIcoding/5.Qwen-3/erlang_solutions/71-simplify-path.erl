-module(simplify_path).
-export([simplify_path/1]).

simplify_path(Path) ->
    lists:reverse(simplify_path(lists:split(1, Path), [])).

simplify_path({[], _}, Acc) ->
    lists:flatten(Acc);
simplify_path({[H | T], Rest}, Acc) when H == $/ ->
    simplify_path({T, Rest}, Acc);
simplify_path({[H | T], Rest}, Acc) when H == $. ->
    case T of
        [$. | _] when length(T) >= 2 ->
            simplify_path({lists:nthtail(2, T), Rest}, Acc);
        [$/ | _] ->
            simplify_path({lists:nthtail(1, T), Rest}, Acc);
        _ ->
            simplify_path({T, Rest}, Acc)
    end;
simplify_path({[H | T], Rest}, Acc) ->
    Name = get_name([H | T], []),
    simplify_path(Rest, [Name | Acc]).

get_name([], Acc) ->
    lists:reverse(Acc);
get_name([$/ | _], Acc) ->
    lists:reverse(Acc);
get_name([H | T], Acc) ->
    get_name(T, [H | Acc]).