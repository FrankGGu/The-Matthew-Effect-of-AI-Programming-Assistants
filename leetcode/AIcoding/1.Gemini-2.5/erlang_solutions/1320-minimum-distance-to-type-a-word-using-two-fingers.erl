-module(solution).
-export([minimumDistance/1]).

char_to_coords(Char) ->
    Val = Char - $A,
    {Val div 6, Val rem 6}.

get_distance(Char1, Char2) when Char1 == Char2 -> 0;
get_distance(Char1, Char2) ->
    {R1, C1} = char_to_coords(Char1),
    {R2, C2} = char_to_coords(Char2),
    abs(R1 - R2) + abs(C1 - C2).

-define(MEMO_TABLE, ets:new(memo_table, [set, public, named_table])).

minimumDistance(Word) ->
    ets:new(?MEMO_TABLE, [set, public, named_table]),

    WordLen = length(Word),
    WordBin = list_to_binary(Word),

    Result = solve(0, '$', '$', WordBin, WordLen),

    ets:delete(?MEMO_TABLE),
    Result.

solve(Idx, _Char1, _Char2, _WordBin, WordLen) when Idx == WordLen ->
    0;
solve(Idx, Char1, Char2, WordBin, WordLen) ->
    case ets:lookup(?MEMO_TABLE, {Idx, Char1, Char2}) of
        [{_, _, Value}] ->
            Value;
        [] ->
            TargetChar = binary:at(WordBin, Idx),

            Cost1_move = 
                case Char1 of
                    '$' -> 0;
                    _ -> get_distance(Char1, TargetChar)
                end,
            Res1 = Cost1_move + solve(Idx + 1, TargetChar, Char2, WordBin, WordLen),

            Cost2_move = 
                case Char2 of
                    '$' -> 0;
                    _ -> get_distance(Char2, TargetChar)
                end,
            Res2 = Cost2_move + solve(Idx + 1, Char1, TargetChar, WordBin, WordLen),

            MinCost = min(Res1, Res2),

            ets:insert(?MEMO_TABLE, {{Idx, Char1, Char2}, MinCost}),
            MinCost
    end.