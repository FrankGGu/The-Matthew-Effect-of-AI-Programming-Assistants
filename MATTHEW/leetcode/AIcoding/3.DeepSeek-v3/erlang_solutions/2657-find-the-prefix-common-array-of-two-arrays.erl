-spec find_the_prefix_common_array(A :: [integer()], B :: [integer()]) -> [integer()].
find_the_prefix_common_array(A, B) ->
    find_the_prefix_common_array(A, B, sets:new(), 0, []).

find_the_prefix_common_array([], [], _, _, Acc) ->
    lists:reverse(Acc);
find_the_prefix_common_array([HA | TA], [HB | TB], Set, Count, Acc) ->
    NewSet1 = sets:add_element(HA, Set),
    NewCount1 = case sets:is_element(HA, Set) of
        true -> Count + 1;
        false -> Count
    end,
    NewSet2 = sets:add_element(HB, NewSet1),
    NewCount2 = case sets:is_element(HB, NewSet1) of
        true -> NewCount1 + 1;
        false -> NewCount1
    end,
    find_the_prefix_common_array(TA, TB, NewSet2, NewCount2, [NewCount2 | Acc]).