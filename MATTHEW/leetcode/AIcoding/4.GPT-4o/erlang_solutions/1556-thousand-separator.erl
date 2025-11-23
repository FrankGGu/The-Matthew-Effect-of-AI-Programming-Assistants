-module(solution).
-export([thousand_separator/1]).

thousand_separator(N) ->
    lists:flatten(integer_to_list(N)) ++ "." ++ lists:reverse(thousand_helper(lists:reverse(integer_to_list(N)))).

thousand_helper([]) ->
    [];
thousand_helper(L) ->
    case lists:splitwith(fun(_) -> true end, L) of
        {Prefix, []} -> Prefix;
        {Prefix, Suffix} ->
            case lists:split(3, Prefix) of
                {Part, Rest} -> lists:reverse(Part) ++ "." ++ thousand_helper(Rest)
            end
    end.