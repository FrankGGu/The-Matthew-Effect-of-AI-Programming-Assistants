-module(solution).
-export([fractionAddition/1]).

fractionAddition(Expression) ->
    {Num, Denom} = list_to_fraction(Expression),
    gcd = gcd(Num, Denom),
    integer_to_list(Num div gcd) ++ "/" ++ integer_to_list(Denom div gcd).

list_to_fraction(Expression) ->
    {Sum, Denom} = lists:foldl(fun(Chunk, {AccNum, AccDen}) ->
        {Num, Den} = parse_chunk(Chunk),
        NewDen = AccDen * Den,
        NewNum = AccNum * (NewDen div AccDen) + Num * (NewDen div Den),
        {NewNum, NewDen}
    end, {0, 1}, split_chunks(Expression)),
    {Sum, Denom}.

parse_chunk(Chunk) ->
    {Num, Denom} = lists:splitwith(fun(C) -> C /= '/' end, Chunk),
    Num = list_to_integer(Num),
    Denom = case Denom of
        [] -> 1;
        [_ | DenomTail] -> list_to_integer(DenomTail)
    end,
    {Num, Denom}.

split_chunks(Expression) ->
    lists:map(fun(X) -> string:to_list(X) end,
        string:split(Expression, "+", all) ++ 
        string:split(Expression, "-", all)).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B.