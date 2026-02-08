-module(alphabet_board_path).
-export([find_path/1]).

find_path(S) ->
    find_path(S, 0, 0, []).

find_path([], _, _, Path) ->
    lists:reverse(Path);
find_path([C | Rest], X, Y, Path) ->
    {NewX, NewY} = char_to_pos(C),
    Move = move(X, Y, NewX, NewY),
    find_path(Rest, NewX, NewY, [Move | Path]).

char_to_pos($a) -> {0, 0};
char_to_pos($b) -> {0, 1};
char_to_pos($c) -> {0, 2};
char_to_pos($d) -> {0, 3};
char_to_pos($e) -> {0, 4};
char_to_pos($f) -> {1, 0};
char_to_pos($g) -> {1, 1};
char_to_pos($h) -> {1, 2};
char_to_pos($i) -> {1, 3};
char_to_pos($j) -> {1, 4};
char_to_pos($k) -> {2, 0};
char_to_pos($l) -> {2, 1};
char_to_pos($m) -> {2, 2};
char_to_pos($n) -> {2, 3};
char_to_pos($o) -> {2, 4};
char_to_pos($p) -> {3, 0};
char_to_pos($q) -> {3, 1};
char_to_pos($r) -> {3, 2};
char_to_pos($s) -> {3, 3};
char_to_pos($t) -> {3, 4};
char_to_pos($u) -> {4, 0};
char_to_pos($v) -> {4, 1};
char_to_pos($w) -> {4, 2};
char_to_pos($x) -> {4, 3};
char_to_pos($y) -> {4, 4};
char_to_pos($z) -> {5, 0}.

move(FromX, FromY, ToX, ToY) ->
    Dx = ToX - FromX,
    Dy = ToY - FromY,
    DirX = if Dx > 0 -> "D"; Dx < 0 -> "U"; true -> "" end,
    DirY = if Dy > 0 -> "R"; Dy < 0 -> "L"; true -> "" end,
    DirX ++ DirY ++ "!".

move(FromX, FromY, 5, 0) when FromX == 4, FromY == 4 ->
    "U" ++ move(4, 4, 5, 0);
move(FromX, FromY, 5, 0) ->
    move(FromX, FromY, 5, 0).