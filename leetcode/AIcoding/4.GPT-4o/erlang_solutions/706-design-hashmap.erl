-module(MyHashMap).
-export([new/0, put/3, get/2, remove/2]).

-record(bucket, {key, value, next}).

new() ->
    {ok, []}.

put(Map, Key, Value) ->
    Hash = erlang:phash2(Key, 1000),
    Bucket = element(Hash + 1, Map),
    NewBucket = put_in_bucket(Bucket, Key, Value),
    Map1 = list_to_tuple(lists:replace_at(Map, Hash + 1, NewBucket)),
    Map1.

get(Map, Key) ->
    Hash = erlang:phash2(Key, 1000),
    Bucket = element(Hash + 1, Map),
    get_from_bucket(Bucket, Key).

remove(Map, Key) ->
    Hash = erlang:phash2(Key, 1000),
    Bucket = element(Hash + 1, Map),
    NewBucket = remove_from_bucket(Bucket, Key),
    Map1 = list_to_tuple(lists:replace_at(Map, Hash + 1, NewBucket)),
    Map1.

put_in_bucket(undefined, Key, Value) ->
    #bucket{key=Key, value=Value, next=undefined};
put_in_bucket(#bucket{key=Key, value=_, next=Next} = Bucket, Key, Value) ->
    Bucket#bucket{value=Value};
put_in_bucket(Bucket, Key, Value) ->
    Bucket#bucket{next=put_in_bucket(Next, Key, Value)}.

get_from_bucket(undefined, _) ->
    -1;
get_from_bucket(#bucket{key=Key, value=Value, next=_}, Key) ->
    Value;
get_from_bucket(#bucket{key=_, value=_, next=Next}, Key) ->
    get_from_bucket(Next, Key).

remove_from_bucket(undefined, _) ->
    undefined;
remove_from_bucket(#bucket{key=Key, value=_, next=Next}, Key) ->
    Next;
remove_from_bucket(#bucket{key=_, value=_, next=Next}, Key) ->
    #bucket{key=Key, value=Value, next=remove_from_bucket(Next, Key)}.