-module(merge_arrays).
-export([merge_arrays/2]).

merge_arrays(Nums1, Nums2) ->
    Dict1 = lists:foldl(fun([Id, Val], Acc) -> dict:store(Id, Val, Acc) end, dict:new(), Nums1),
    Dict2 = lists:foldl(fun([Id, Val], Acc) -> dict:store(Id, Val, Acc) end, dict:new(), Nums2),
    Keys1 = dict:fetch_keys(Dict1),
    Keys2 = dict:fetch_keys(Dict2),
    AllKeys = lists:usort(Keys1 ++ Keys2),
    lists:map(fun(Key) ->
                      Val1 = case dict:is_key(Key, Dict1) of
                                 true -> dict:fetch(Key, Dict1);
                                 false -> 0
                             end,
                      Val2 = case dict:is_key(Key, Dict2) of
                                 true -> dict:fetch(Key, Dict2);
                                 false -> 0
                             end,
                      [Key, Val1 + Val2]
              end, AllKeys).