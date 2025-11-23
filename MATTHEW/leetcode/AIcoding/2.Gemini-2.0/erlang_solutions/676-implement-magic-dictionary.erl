-module(magic_dictionary).
-export([new/0, buildDict/2, search/2]).

new() ->
    {dict:new(), []}.

buildDict({Dict, _}, Words) ->
    {dict:from_list([{W, true} || W <- Words]), Words}.

search({Dict, Words}, SearchWord) ->
    lists:any(fun(Word) ->
                      string:len(Word) == string:len(SearchWord) andalso
                          diff_by_one(Word, SearchWord)
              end, Words).

diff_by_one(Word1, Word2) ->
    diff_by_one(Word1, Word2, 0).

diff_by_one([], [], Diff) ->
    Diff == 1;
diff_by_one([H1 | T1], [H2 | T2], Diff) ->
    case H1 == H2 of
        true ->
            diff_by_one(T1, T2, Diff);
        false ->
            diff_by_one(T1, T2, Diff + 1)
    end;
diff_by_one(_, _, _) ->
    false.