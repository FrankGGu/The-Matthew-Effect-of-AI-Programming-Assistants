-module(remove_methods_from_project).
-export([remove_methods/1]).

remove_methods(Methods) ->
    lists:foldl(fun(Method, Acc) ->
        case lists:keymember(Method, 1, Acc) of
            true -> Acc;
            false -> [Method | Acc]
        end
    end, [], Methods).