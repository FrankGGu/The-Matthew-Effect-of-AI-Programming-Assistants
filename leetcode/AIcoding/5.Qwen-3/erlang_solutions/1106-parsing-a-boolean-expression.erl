-module(boolean_parser).
-export([parse_bool/1]).

parse_bool(Str) ->
    {Result, _} = parse_expr(Str, 0),
    Result.

parse_expr([], _) -> {false, 0};
parse_expr([$\s|T], Pos) -> parse_expr(T, Pos + 1);
parse_expr([$\(|T], Pos) -> parse_expr(T, Pos + 1);
parse_expr([$\)|T], Pos) -> {true, Pos + 1};
parse_expr([$\&|T], Pos) -> parse_and(T, Pos + 1);
parse_expr([$\||T], Pos) -> parse_or(T, Pos + 1);
parse_expr([$\!|T], Pos) -> parse_not(T, Pos + 1);
parse_expr([$\t|T], Pos) -> parse_expr(T, Pos + 1);
parse_expr([$\f|T], Pos) -> {false, Pos + 1};
parse_expr([$\t|T], Pos) -> {true, Pos + 1}.

parse_and([], _) -> {false, 0};
parse_and([$\(|T], Pos) -> 
    {A, P} = parse_expr(T, Pos + 1),
    parse_and_rest(T, P, A);
parse_and([$\s|T], Pos) -> parse_and(T, Pos + 1);
parse_and([$\)|T], Pos) -> {true, Pos + 1}.

parse_and_rest([], _, _) -> {false, 0};
parse_and_rest([$\s|T], Pos, A) -> parse_and_rest(T, Pos + 1, A);
parse_and_rest([$\(|T], Pos, A) -> 
    {B, P} = parse_expr(T, Pos + 1),
    parse_and_rest(T, P, A andalso B);
parse_and_rest([$\)|T], Pos, A) -> {A, Pos + 1}.

parse_or([], _) -> {false, 0};
parse_or([$\(|T], Pos) -> 
    {A, P} = parse_expr(T, Pos + 1),
    parse_or_rest(T, P, A);
parse_or([$\s|T], Pos) -> parse_or(T, Pos + 1);
parse_or([$\)|T], Pos) -> {true, Pos + 1}.

parse_or_rest([], _, _) -> {false, 0};
parse_or_rest([$\s|T], Pos, A) -> parse_or_rest(T, Pos + 1, A);
parse_or_rest([$\(|T], Pos, A) -> 
    {B, P} = parse_expr(T, Pos + 1),
    parse_or_rest(T, P, A orelse B);
parse_or_rest([$\)|T], Pos, A) -> {A, Pos + 1}.

parse_not([], _) -> {false, 0};
parse_not([$\(|T], Pos) -> 
    {A, P} = parse_expr(T, Pos + 1),
    {not A, P + 1};
parse_not([$\s|T], Pos) -> parse_not(T, Pos + 1);
parse_not([$\)|T], Pos) -> {true, Pos + 1}.