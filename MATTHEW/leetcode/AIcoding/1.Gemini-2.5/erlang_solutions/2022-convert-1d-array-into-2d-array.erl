-module(solution).
-export([convert_1d_to_2d/3]).

-spec convert_1d_to_2d(Original :: [integer()], M :: integer(), N :: integer()) -> [[integer()]].
convert_1d_to_2d(Original, M, N) when M * N =:= length(Original) ->
    convert_1d_to_2d_impl(Original, M, N, []);
convert_1d_to_2d(_Original, _M, _N) ->
    [].

convert_1d_to_2d_impl([], 0, _N, Acc) ->
    lists:reverse(Acc);
convert_1d_to_2d_impl(Original, M, N, Acc) ->
    {Row, Rest} = lists:split(N, Original),
    convert_1d_to_2d_impl(Rest, M - 1, N, [Row | Acc]).