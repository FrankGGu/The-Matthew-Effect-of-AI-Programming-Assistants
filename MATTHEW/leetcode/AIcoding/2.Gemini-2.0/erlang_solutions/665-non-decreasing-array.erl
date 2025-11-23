-module(non_decreasing_array).
-export([check_possibility/1]).

check_possibility(Nums) ->
    check_possibility(Nums, 0, false).

check_possibility([], _, _) ->
    true;
check_possibility([_], _, _) ->
    true;
check_possibility([A, B | Rest], Count, Modified) ->
    if
        A =< B ->
            check_possibility([B | Rest], Count, Modified);
        true ->
            if
                Modified ->
                    false;
                true ->
                    if
                        Count =:= 0 ->
                            check_possibility([B | Rest], Count + 1, true);
                        true ->
                            if
                                length([A,B|Rest]) =:= 2 ->
                                    true;
                                hd(Rest) >= A ->
                                    check_possibility([B | Rest], Count + 1, true);
                                true ->
                                    check_possibility([A|Rest],Count+1,true)
                            end
                    end
            end
    end.