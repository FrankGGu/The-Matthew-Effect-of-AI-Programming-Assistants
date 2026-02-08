-module(MyHashSet).
-export([new/0, add/2, remove/2, contains/2]).

-record(hashset, {buckets = []}).

new() ->
    HashSet = #hashset{buckets = lists:duplicate(1000, [])},
    HashSet.

add(HashSet, Key) ->
    BucketIndex = Key rem 1000,
    Buckets = HashSet#hashset.buckets,
    NewBucket = lists:append([Key], lists:nth(BucketIndex + 1, Buckets)),
    NewBuckets = lists:replace(BucketIndex + 1, NewBucket, Buckets),
    HashSet#hashset{buckets = NewBuckets}.

remove(HashSet, Key) ->
    BucketIndex = Key rem 1000,
    Buckets = HashSet#hashset.buckets,
    NewBucket = lists:filter(fun(X) -> X /= Key end, lists:nth(BucketIndex + 1, Buckets)),
    NewBuckets = lists:replace(BucketIndex + 1, NewBucket, Buckets),
    HashSet#hashset{buckets = NewBuckets}.

contains(HashSet, Key) ->
    BucketIndex = Key rem 1000,
    Bucket = lists:nth(BucketIndex + 1, HashSet#hashset.buckets),
    lists:member(Key, Bucket).