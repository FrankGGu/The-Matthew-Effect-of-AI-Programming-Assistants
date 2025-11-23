-module(magic_dict).
-export([buildDict/1, search/2]).

buildDict(Dict) ->
    spawn(fun() -> loop(Dict) end).

search(Pid, Word) ->
    Pid ! {self(), search, Word},
    receive
        {Pid, Result} -> Result
    after 1000 -> false
    end.

loop(Dict) ->
    receive
        {From, search, Word} ->
            Result = lists:any(fun(DictWord) ->
                case length(DictWord) =:= length(Word) of
                    true ->
                        lists:sum(lists:zipwith(fun(A, B) -> if A =:= B -> 0; true -> 1 end end, DictWord, Word)) =:= 1;
                    false -> false
                end
            end, Dict),
            From ! {self(), Result},
            loop(Dict);
        _ -> loop(Dict)
    end.