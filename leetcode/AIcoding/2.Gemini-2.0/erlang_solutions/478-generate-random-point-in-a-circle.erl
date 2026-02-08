-module(solution).
-export([solution/1, gen_random/1]).

solution(Radius) ->
    {ok, State} = gen_random:new(Radius),
    {state, State}.

gen_random(State) ->
    gen_random:gen_point(State).

-module(gen_random).
-export([new/1, gen_point/1]).

new(Radius) ->
    {ok, {rand:seed(), Radius}}.

gen_point({Seed, Radius}) ->
    {X, Y} = generate_point(Radius),
    {ok, {X, Y}, {Seed, Radius}}.

generate_point(Radius) ->
    generate_point_helper(Radius,rand:uniform(),rand:uniform()).

generate_point_helper(Radius,U1,U2) ->
    V1 = 2 * U1 - 1,
    V2 = 2 * U2 - 1,
    S = V1 * V1 + V2 * V2,
    if
        S > 1 ->
            generate_point_helper(Radius,rand:uniform(),rand:uniform());
        true ->
            Multiplier = Radius * math:sqrt(rand:uniform() / S),
            {V1 * Multiplier, V2 * Multiplier}
    end.