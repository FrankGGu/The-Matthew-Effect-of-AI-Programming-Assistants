-module(solution).
-export([num_steps/1]).

num_steps(BinStr) ->
    num_steps(BinStr, 0).

num_steps(<<"1">>, Steps) ->
    Steps;
num_steps(BinStr, Steps) ->
    Len = erlang:length(BinStr),
    if
        Len == 1 ->
            Steps;
        true ->
            case erlang:binary:last(BinStr) of
                $1 ->
                    NewBin = erlang:binary:replace(BinStr, <<",">>, <<>>, [global]),
                    num_steps(erlang:list_to_binary([erlang:integer_to_list(erlang:binary_to_integer(NewBin, 2) + 1)]), Steps + 1);
                $0 ->
                    num_steps(erlang:binary:replace(BinStr, <<",">>, <<>>, [global]), Steps + 1)
            end
    end.