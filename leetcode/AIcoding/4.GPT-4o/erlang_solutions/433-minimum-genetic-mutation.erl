-module(solution).
-export([min_mutation/3]).

-define(GENES, [$A, $C, $G, $T]).

-spec min_mutation(binary(), binary(), [binary()]) -> integer().
min_mutation(Start, End, Bank) ->
    BankSet = sets:from_list(Bank),
    if
        not sets:is_element(End, BankSet) -> -1;
        true -> bfs([{Start, 0}], sets:new(), BankSet, End)
    end.

bfs([], _, _, _) -> -1;
bfs([{Current, Step} | Rest], Visited, BankSet, End) ->
    case Current == End of
        true -> Step;
        false ->
            Visited1 = sets:add_element(Current, Visited),
            NextList = neighbors(Current, BankSet, Visited1),
            bfs(Rest ++ [{N, Step + 1} || N <- NextList], Visited1, BankSet, End)
    end.

neighbors(Gene, BankSet, Visited) ->
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(C, Acc2) ->
            case string:substr(Gene, I+1, 1) of
                [C] -> Acc2;
                _ ->
                    NewGene = replace_char(Gene, I, C),
                    if
                        sets:is_element(NewGene, BankSet),
                        not sets:is_element(NewGene, Visited) ->
                            [NewGene | Acc2];
                        true -> Acc2
                    end
            end
        end, Acc, ?GENES)
    end, [], lists:seq(0, 7)).

replace_char(Bin, Index, Char) ->
    <<Prefix:Index/binary, _:8, Suffix/binary>> = Bin,
    <<Prefix/binary, Char, Suffix/binary>>.
