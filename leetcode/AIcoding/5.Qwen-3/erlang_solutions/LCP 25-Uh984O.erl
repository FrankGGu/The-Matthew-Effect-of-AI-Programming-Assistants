-module(solution).
-export([find-possible-words/1]).

find_possible_words(WordList) ->
    KeyMap = #{
        $a => [1,2],
        $b => [1,2],
        $c => [1,2],
        $d => [3],
        $e => [1,2],
        $f => [3],
        $g => [3],
        $h => [3],
        $i => [1,2],
        $j => [4],
        $k => [4],
        $l => [4],
        $m => [5],
        $n => [5],
        $o => [1,2],
        $p => [5],
        $q => [1,2],
        $r => [1,2],
        $s => [3],
        $t => [3],
        $u => [1,2],
        $v => [5],
        $w => [1,2],
        $x => [3],
        $y => [1,2],
        $z => [3]
    },
    lists:filter(fun(Word) -> is_valid_word(Word, KeyMap) end, WordList).

is_valid_word([], _) -> true;
is_valid_word([Char | Rest], KeyMap) ->
    case maps:get(Char, KeyMap, []) of
        [] -> false;
        [First] -> is_valid_word(Rest, KeyMap);
        [First, Second] ->
            case Rest of
                [] -> true;
                [Next | _] ->
                    case maps:get(Next, KeyMap, []) of
                        [First] -> is_valid_word(Rest, KeyMap);
                        _ -> false
                    end
            end
    end.