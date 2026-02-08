-module(minimum_genetic_mutation).
-export([min_mutation/2]).

min_mutation(StartGene, EndGene) ->
    min_mutation(StartGene, EndGene, ["A", "C", "G", "T"], 0, sets:new()).

min_mutation(StartGene, EndGene, _Options, Steps, _Visited) when StartGene == EndGene ->
    Steps;

min_mutation(StartGene, EndGene, Options, Steps, Visited) ->
    NextGenes = lists:flatmap(fun(O) -> 
        lists:map(fun(I) -> 
            string:substr(StartGene, 1, I) ++ O ++ string:substr(StartGene, I+2)
        end, lists:seq(0, length(StartGene)-1))
    end, Options),
    NextGenesFiltered = lists:filter(fun(G) -> G /= StartGene end, NextGenes),
    NextGenesSorted = lists:sort(NextGenesFiltered),
    lists:foldl(fun(G, Acc) ->
        case sets:is_element(G, Visited) of
            true -> Acc;
            false ->
                NewVisited = sets:add_element(G, Visited),
                Result = min_mutation(G, EndGene, Options, Steps + 1, NewVisited),
                if Result /= -1 -> Result; true -> Acc end
        end
    end, -1, NextGenesSorted).

min_mutation(_StartGene, EndGene, _Options, Steps, _Visited) when EndGene /= "" ->
    -1.