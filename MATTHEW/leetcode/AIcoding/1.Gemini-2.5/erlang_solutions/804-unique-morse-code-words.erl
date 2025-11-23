-module(solution).
-export([uniqueMorseRepresentations/1]).

uniqueMorseRepresentations(Words) ->
    MorseMap = #{
        $a => ".-", $b => "-...", $c => "-.-.", $d => "-..", $e => ".",
        $f => "..-.", $g => "--.", $h => "....", $i => "..", $j => ".---",
        $k => "-.-", $l => ".-..", $m => "--", $n => "-.", $o => "---",
        $p => ".--.", $q => "--.-", $r => ".-.", $s => "...", $t => "-",
        $u => "..-", $v => "...-", $w => ".--", $x => "-..-", $y => "-.--",
        $z => "--.."
    },
    UniqueMorseSet = lists:foldl(
        fun(Word, AccSet) ->
            MorseWord = lists:foldl(
                fun(Char, AccMorse) ->
                    AccMorse ++ maps:get(Char, MorseMap)
                end,
                "",
                Word
            ),
            sets:add_element(MorseWord, AccSet)
        end,
        sets:new(),
        Words
    ),
    sets:size(UniqueMorseSet).