-module(solution).
-export([build_h2o/3]).

build_h2o(N, H, O) ->
    spawn(fun() -> create_h2o(N, H, O, 0) end).

create_h2o(N, H, O, Count) ->
    case Count of
        N -> ok;
        _ ->
            receive
                {h, Caller} ->
                    if O > 0 andalso H >= 2 -> 
                        io:format("H~n"),
                        create_h2o(N, H - 1, O, Count);
                    true -> 
                        create_h2o(N, H, O, Count)
                    end,
                {o, Caller} ->
                    if H >= 2 andalso O > 0 -> 
                        io:format("O~n"),
                        create_h2o(N, H, O - 1, Count + 1);
                    true -> 
                        create_h2o(N, H, O, Count)
                    end
            end
    end.