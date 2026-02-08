-module(solution).
-export([select_data/1]).

select_data(Data) ->
    [X || X <- Data, condition(X)].

condition(X) ->
    % 替换为具体的条件判断逻辑
    true.