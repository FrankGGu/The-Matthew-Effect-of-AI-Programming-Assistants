-module(decode_ways_ii).
-export([num_decodings/1]).

num_decodings(S) ->
    S_list = string:to_list(S),
    N = length(S_list),
    num_decodings_helper(S_list, N).

num_decodings_helper(S_list, N) ->
    Mod = 1000000007,
    dp_0 = 1,
    dp_1 = case lists:nth(1, [S_list]) of
               $* -> 9;
               $0 -> 0;
               C ->
                   if C >= $1, C =< $9 -> 1;
                      true -> 0
                   end
           end,
    foldl(fun(I, {Prev, Curr}) ->
                  Next = 
                    case lists:nth(I + 1, [S_list]) of
                      $* ->
                          Res1 = (Curr * 9) rem Mod,
                          Res2 =
                            case lists:nth(I, [S_list]) of
                              $1 -> (Prev * 9) rem Mod;
                              $2 -> (Prev * 6) rem Mod;
                              $* -> (Prev * 15) rem Mod;
                              _ -> 0
                            end,
                          Res3 =
                            case lists:nth(I, [S_list]) of
                              $1 -> Prev rem Mod;
                              $2 -> Prev rem Mod;
                              $* -> (Prev * 2) rem Mod;
                              _ -> 0
                            end,
                          ((Res1 + Res2 + Res3) rem Mod);
                      $0 ->
                          case lists:nth(I, [S_list]) of
                            $1 -> Prev rem Mod;
                            $2 -> Prev rem Mod;
                            $* -> (Prev * 2) rem Mod;
                            _ -> 0
                          end;
                      C ->
                          Res1 =
                            if C >= $1, C =< $9 -> Curr rem Mod;
                               true -> 0
                            end,
                          Res2 =
                            case lists:nth(I, [S_list]) of
                              $1 -> Prev rem Mod;
                              $2 ->
                                if C >= $1, C =< $6 -> Prev rem Mod;
                                   true -> 0
                                end;
                              $* ->
                                if C >= $1, C =< $6 -> Prev rem Mod;
                                   true -> 0
                                end;
                              _ -> 0
                            end,
                          ((Res1 + Res2) rem Mod)
                    end,
                  {Curr, Next}
          end, lists:seq(1, N - 1), {dp_0, dp_1}) of
        {_, Result} -> Result
    end.