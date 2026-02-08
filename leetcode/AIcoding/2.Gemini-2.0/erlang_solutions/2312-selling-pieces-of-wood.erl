-module(selling_wood).
-export([selling_pieces/1]).

selling_pieces(M) ->
    {H, W, Prices} = parse_input(M),
    DP = array:new([H+1, W+1], {fixed, 0}),

    lists:foreach(fun({h, w, price}) ->
        array:set(DP, [h, w], price)
    end, Prices),

    for(1, H, 1, fun(I) ->
        for(1, W, 1, fun(J) ->
            MaxVal = array:get(DP, [I, J]),

            % Horizontal cuts
            for(1, I-1, 1, fun(K) ->
                Val = array:get(DP, [K, J]) + array:get(DP, [I-K, J]);
                array:set(DP, [I, J], max(MaxVal, Val)),
                ok
            end),

            % Vertical cuts
            for(1, J-1, 1, fun(K) ->
                Val = array:get(DP, [I, K]) + array:get(DP, [I, J-K]);
                array:set(DP, [I, J], max(MaxVal, Val)),
                ok
            end),
            ok
        end)
    end),

    array:get(DP, [H, W]).

parse_input(M) ->
    H = hd(hd(M)),
    W = hd(tl(hd(M))),
    Prices = [
        {h, hd(P), w, hd(tl(P)), price, hd(tl(tl(P)))}
        || P <- tl(M)
    ],
    {H, W, [ {H1, W1, Price1} || {h, H1, w, W1, price, Price1} <- Prices]}.

for(From, To, Step, Fun) ->
    for(From, To, Step, Fun, ok).

for(I, To, Step, Fun, Acc) when I > To ->
    Acc;
for(I, To, Step, Fun, Acc) ->
    NewAcc = Fun(I),
    for(I + Step, To, Step, Fun, NewAcc).