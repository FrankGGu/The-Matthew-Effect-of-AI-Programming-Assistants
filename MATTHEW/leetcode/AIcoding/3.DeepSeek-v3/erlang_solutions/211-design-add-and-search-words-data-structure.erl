-module(word_dict).
-export([new/0, add_word/2, search/2]).

new() ->
    #{}.

add_word(Dict, Word) ->
    lists:foldl(fun(Char, Acc) ->
        case Acc of
            #{current := Children} -> 
                case maps:get(Char, Children, none) of
                    none -> 
                        NewChildren = maps:put(Char, #{current => #{}}, Children),
                        Acc#{current := NewChildren};
                    _ -> 
                        Acc
                end;
            _ -> 
                #{current => #{Char => #{current => #{}}}}
        end
    end, Dict, Word).

search(Dict, Word) ->
    search_word(Dict, Word).

search_word(Dict, []) ->
    maps:is_key(current, Dict);
search_word(Dict, [$. | Rest]) ->
    case Dict of
        #{current := Children} ->
            lists:any(fun({_, Child}) -> search_word(Child, Rest) end, maps:to_list(Children));
        _ -> false
    end;
search_word(Dict, [Char | Rest]) ->
    case Dict of
        #{current := Children} ->
            case maps:get(Char, Children, none) of
                none -> false;
                Child -> search_word(Child, Rest)
            end;
        _ -> false
    end.