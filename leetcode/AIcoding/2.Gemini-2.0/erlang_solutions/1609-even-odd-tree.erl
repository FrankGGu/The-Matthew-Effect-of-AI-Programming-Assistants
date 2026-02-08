-module(even_odd_tree).
-export([isEvenOddTree/1]).

isEvenOddTree(Root) ->
    isEvenOddTree(Root, 0).

isEvenOddTree(Root, Level) ->
    Queue = [{Root, Level}],
    isEvenOddTreeHelper(Queue, []).

isEvenOddTreeHelper([], _) ->
    true;
isEvenOddTreeHelper(Queue, Levels) ->
    {Node, Level} = hd(Queue),
    RestQueue = tl(Queue),

    case Node of
        null ->
            isEvenOddTreeHelper(RestQueue, Levels);
        _ ->
            Val = element(1, Node),
            case Level rem 2 of
                0 ->
                    case Val rem 2 of
                        0 ->
                            false;
                        1 ->
                            case lists:keyfind(Level, 1, Levels) of
                                false ->
                                    isEvenOddTreeHelper(RestQueue ++ [{element(2, Node), Level + 1}, {element(3, Node), Level + 1}], [{Level, Val} | Levels]);
                                {_, PrevVal} ->
                                    case Val > PrevVal of
                                        true ->
                                            isEvenOddTreeHelper(RestQueue ++ [{element(2, Node), Level + 1}, {element(3, Node), Level + 1}], lists:keyreplace(Level, 1, Levels, {Level, Val}));
                                        false ->
                                            false
                                    end
                            end;
                        _ ->
                            false
                    end;
                1 ->
                    case Val rem 2 of
                        1 ->
                            false;
                        0 ->
                            case lists:keyfind(Level, 1, Levels) of
                                false ->
                                    isEvenOddTreeHelper(RestQueue ++ [{element(2, Node), Level + 1}, {element(3, Node), Level + 1}], [{Level, Val} | Levels]);
                                {_, PrevVal} ->
                                    case Val < PrevVal of
                                        true ->
                                            isEvenOddTreeHelper(RestQueue ++ [{element(2, Node), Level + 1}, {element(3, Node), Level + 1}], lists:keyreplace(Level, 1, Levels, {Level, Val}));
                                        false ->
                                            false
                                    end
                            end;
                        _ ->
                            false
                    end
            end
    end.