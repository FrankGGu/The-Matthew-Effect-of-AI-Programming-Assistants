-module(solve_equation).
-export([solve/1]).

solve(Equation) ->
    parse(Equation, 0, 0, 0, 0, 0, 0).

parse([], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    X = CoeffX,
    Y = CoeffY,
    Z = CoeffZ,
    C = Const + ConstY + ConstZ,
    if
        X == 0 andalso Y == 0 andalso Z == 0 ->
            if
                C == 0 -> "Infinite solutions";
                true -> "No solution"
            end;
        true ->
            Total = X + Y + Z,
            if
                Total == 0 ->
                    if
                        C == 0 -> "Infinite solutions";
                        true -> "No solution"
                    end;
                true ->
                    Result = -C div Total,
                    io_lib:format("x=~p", [Result])
            end
    end;

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H == $+ ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H == $- ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ);

parse([$x|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    parse(T, CoeffX + 1, Const, CoeffY, ConstY, CoeffZ, ConstZ);

parse([$y|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    parse(T, CoeffX, Const, CoeffY + 1, ConstY, CoeffZ, ConstZ);

parse([$z|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ + 1, ConstZ);

parse([$=|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H >= $0 andalso H =< $9 ->
    {Num, Rest} = read_number([H|T]),
    parse(Rest, CoeffX, Const + Num, CoeffY, ConstY, CoeffZ, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H == $x ->
    parse(T, CoeffX + 1, Const, CoeffY, ConstY, CoeffZ, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H == $y ->
    parse(T, CoeffX, Const, CoeffY + 1, ConstY, CoeffZ, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) when H == $z ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ + 1, ConstZ);

parse([H|T], CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ) ->
    parse(T, CoeffX, Const, CoeffY, ConstY, CoeffZ, ConstZ).

read_number([]) -> {0, []};
read_number([H|T]) when H >= $0 andalso H =< $9 ->
    {Num, Rest} = read_number(T),
    {Num + (H - $0) * 10, Rest};
read_number([H|T]) ->
    {0, [H|T]}.