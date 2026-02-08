-module(solution).
-export([crawler_log_folder/1]).

crawler_log_folder(Logs) ->
    lists:foldl(
        fun(Log, Depth) ->
            case Log of
                "../" ->
                    erlang:max(0, Depth - 1);
                "./" ->
                    Depth;
                _ ->
                    Depth + 1
            end
        end,
        0,
        Logs
    ).