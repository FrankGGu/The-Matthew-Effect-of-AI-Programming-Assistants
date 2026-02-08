-module(solution).
-export([are_almost_equal/2]).

are_almost_equal(Str1, Str2) ->
    case string:len(Str1) =:= string:len(Str2) of
        false -> false;
        true ->
            Diff = lists:filter(fun({A, B}) -> A =/= B end, lists:zip(string:to_list(Str1), string:to_list(Str2))),
            case length(Diff) of
                0 -> true;
                2 -> 
                    [{A1, B1}, {A2, B2}] = Diff,
                    A1 =:= B2 andalso A2 =:= B1;
                _ -> false
            end
    end.