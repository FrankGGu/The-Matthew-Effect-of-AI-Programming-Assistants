-module(solution).
-export([check_if_exist/1]).

check_if_exist(Arr) ->
  Set = sets:from_list(Arr),
  lists:any(fun(X) ->
                (X * 2 =:= X andalso lists:member(X, Arr) andalso lists:sum([if Y =:= X -> 1 else 0 end || Y <- Arr]) > 1) orelse
                  (X * 2 /= X andalso sets:is_element(X * 2, Set))
            end, Arr).