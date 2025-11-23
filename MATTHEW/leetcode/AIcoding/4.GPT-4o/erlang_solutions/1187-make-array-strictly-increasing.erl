-module(solution).
-export([make_array_increasing/2]).

make_array_increasing(A, B) ->
    make_array_increasing_helper(A, B, 0, 0, dict:new()).

make_array_increasing_helper([], _, _, Count, _) -> 
    Count;
make_array_increasing_helper([H | T], B, Last, Count, Memo) ->
    case dict:find({H, Last}, Memo) of
        {ok, Res} -> Res;
        error ->
            try 
                NewCount = make_array_increasing_helper(T, B, H, Count, dict:store({H, Last}, Count, Memo)) 
            catch 
                _:_ -> 
                    NewCount = make_array_increasing_helper(T, B, Last, Count + 1, dict:store({H + 1, Last}, Count + 1, Memo))
            end,
            case lists:filter(fun(X) -> X > Last end, B) of
                [] -> 
                    NewCount;
                [X | _] ->
                    NewCount1 = make_array_increasing_helper(T, B, X, Count + 1, dict:store({X, Last}, Count + 1, Memo)),
                    min(NewCount, NewCount1)
            end
    end.