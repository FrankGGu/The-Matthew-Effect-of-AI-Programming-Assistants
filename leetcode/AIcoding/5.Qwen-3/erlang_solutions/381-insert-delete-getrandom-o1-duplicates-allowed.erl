-module(InsertDeleteGetRandomO1).
-export([new/0, insert/2, remove/2, get_random/1]).

new() ->
    {dict:new(), dict:new(), 0}.

insert(Key, {Dict, IndexMap, Size}) ->
    case dict:is_key(Key, Dict) of
        true ->
            Index = dict:fetch(Key, IndexMap),
            NewDict = dict:store(Key, Index + 1, Dict),
            NewIndexMap = dict:store(Key, Index + 1, IndexMap),
            {NewDict, NewIndexMap, Size};
        false ->
            NewSize = Size + 1,
            NewDict = dict:store(Key, 1, Dict),
            NewIndexMap = dict:store(Key, 0, IndexMap),
            {NewDict, NewIndexMap, NewSize}
    end.

remove(Key, {Dict, IndexMap, Size}) ->
    case dict:is_key(Key, Dict) of
        true ->
            Count = dict:fetch(Key, Dict),
            if
                Count > 1 ->
                    NewCount = Count - 1,
                    NewDict = dict:store(Key, NewCount, Dict),
                    NewIndexMap = dict:store(Key, 0, IndexMap),
                    {NewDict, NewIndexMap, Size};
                true ->
                    NewDict = dict:erase(Key, Dict),
                    NewIndexMap = dict:erase(Key, IndexMap),
                    {NewDict, NewIndexMap, Size - 1}
            end;
        false ->
            {Dict, IndexMap, Size}
    end.

get_random({Dict, _, _}) ->
    Keys = dict:keys(Dict),
    lists:nth(random:uniform(length(Keys)), Keys).