-module(magic_dict).
-export([buildDict/1, search/2]).

buildDict(Dict) ->
    spawn(fun() -> dict_loop(Dict) end).

search(Pid, Word) ->
    Pid ! {self(), {search, Word}},
    receive
        {Pid, Result} -> Result
    after 1000 -> false
    end.

dict_loop(Dict) ->
    receive
        {From, {search, Word}} ->
            Result = lists:any(fun(DictWord) -> 
                case length(DictWord) =:= length(Word) of
                    true -> 
                        case lists:sum(lists:zipwith(fun(X, Y) -> if X =:= Y -> 0; true -> 1 end end, DictWord, Word)) of
                            1 -> true;
                            _ -> false
                        end;
                    false -> false
                end
            end, Dict),
            From ! {self(), Result},
            dict_loop(Dict);
        _ -> dict_loop(Dict)
    end.