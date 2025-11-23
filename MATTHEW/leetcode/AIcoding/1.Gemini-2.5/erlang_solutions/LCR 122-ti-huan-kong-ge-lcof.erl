-module(solution).
-export([path_encryption/1]).

path_encryption(Path) ->
    Path1 = lists:map(fun(C) -> if C == $. -> $!; true -> C end end, Path),
    Path2 = lists:map(fun(C) -> if C == $/ -> $_; true -> C end end, Path1),
    Path3 = lists:map(fun(C) -> if C == $- -> $*; true -> C end end, Path2),
    Path4 = lists:map(fun(C) -> if C == $_ -> $-; true -> C end end, Path3),
    Path4.