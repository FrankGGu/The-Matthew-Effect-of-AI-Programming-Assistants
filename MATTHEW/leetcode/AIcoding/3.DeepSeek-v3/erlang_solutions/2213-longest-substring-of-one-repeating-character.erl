-module(solution).
-export([max_rep_opt1/1]).

max_rep_opt1(S) ->
    Counts = lists:foldl(fun(C, Acc) ->
                            maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                         end, #{}, S),
    {MaxLen, _} = lists:foldl(fun(C, {Max, {Prev, Len, Same}}) ->
                                case C of
                                    Prev ->
                                        NewLen = Len + 1,
                                        NewSame = Same + 1,
                                        {max(Max, NewLen), {Prev, NewLen, NewSame}};
                                    _ ->
                                        NewLen = Len + 1,
                                        NewSame = 1,
                                        {max(Max, NewLen), {C, NewLen, NewSame}}
                                end
                             end, {0, {none, 0, 0}}, S),
    case maps:size(Counts) of
        1 -> length(S);
        _ -> min(MaxLen, maps:fold(fun(_, V, Acc) -> max(V, Acc) end, 0, Counts))
    end.