-module(solution).
-export([make_strings_equal/2]).

-spec make_strings_equal(S :: unicode:unicode_binary(), Target :: unicode:unicode_binary()) -> boolean().
make_strings_equal(S, Target) ->
    S_list = unicode:characters_to_list(S),
    Target_list = unicode:characters_to_list(Target),

    check_conditions(S_list, Target_list, 0, 0).

check_conditions([], [], S_ones, Target_ones) ->
    (S_ones - Target_ones) rem 2 == 0;
check_conditions([Sh | St], [Th | Tt], S_ones, Target_ones) ->
    case {Sh, Th} of
        {$0, $1} -> false; % If s[k] is '0' but target[k] is '1', impossible
        {$0, $0} -> check_conditions(St, Tt, S_ones, Target_ones);
        {$1, $0} -> check_conditions(St, Tt, S_ones + 1, Target_ones);
        {$1, $1} -> check_conditions(St, Tt, S_ones + 1, Target_ones + 1)
    end.