-module(solution).
-export([is_ugly/1]).

is_ugly(N) when N < 1 ->
    false;
is_ugly(N) ->
    is_ugly_helper(N).

is_ugly_helper(0) ->
    false;
is_ugly_helper(N) when N rem 2 =:= 0 ->
    is_ugly_helper(N div 2);
is_ugly_helper(N) when N rem 3 =:= 0 ->
    is_ugly_helper(N div 3);
is_ugly_helper(N) when N rem 5 =:= 0 ->
    is_ugly_helper(N div 5);
is_ugly_helper(N) ->
    N =:= 1.