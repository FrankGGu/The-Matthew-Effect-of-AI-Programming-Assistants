-module(k_similar_strings).
-export([kSimilarString/2]).

kSimilarString(A, B) ->
    kSimilarString(A, B, 0, 0, dict:new()).

kSimilarString(A, B, Index, Swaps, Visited) ->
    case A == B of
        true -> Swaps;
        false ->
            Key = {A, Index},
            case dict:is_key(Key, Visited) of
                true -> infinity;
                false ->
                    Visited1 = dict:store(Key, Swaps, Visited),
                    MinSwaps = lists:min(
                        [kSimilarString(
                            swap(A, I, Index),
                            B,
                            Index + 1,
                            Swaps + 1,
                            Visited1)
                         || I <- lists:seq(Index + 1, length(A) - 1),
                            lists:nth(I + 1, A) == lists:nth(Index + 1, B)]
                    ),
                    MinSwaps
            end
    end.

swap(List, I, J) ->
    L = erlang:list_to_tuple(List),
    T = erlang:append_element(L, erlang:element(I + 1, L)),
    T1 = erlang:erase_element(I + 1, T),
    T2 = erlang:erase_element(J + 1, T1),
    T3 = erlang:insert_element(J + 1, erlang:element(I + 1, T), T2),
    erlang:tuple_to_list(T3).