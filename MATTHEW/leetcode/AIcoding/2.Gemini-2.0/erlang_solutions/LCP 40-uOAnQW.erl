-module(solution).
-export([card_game/1]).

card_game(cards) ->
    card_game(cards, 0, 0, []).

card_game([], A, B, _) ->
    max(A, B);
card_game([H|T], A, B, LastTwo) ->
    case LastTwo of
        [] ->
            card_game(T, A + H, B, [H]);
        [L1] ->
            card_game(T, A + H, B, [L1, H]);
        [L1, L2] ->
            A1 = A + H;
            B1 = B + min(L1, L2);
            card_game(T, A1, B1, [L2, H])
    end.