-module(number_of_paths_with_max_score).
-export([max_path_sum/1]).

max_path_sum(board) ->
  {N, N} = lists:foldl(fun(_, {X, Y}) -> {X+1, Y+1} end, {0,0}, board),
  DP = array:new([{1,N},{1,N}],{0,0}),
  Count = array:new([{1,N},{1,N}],{0,0}),
  array:set({N,N}, DP, {0,1}),
  array:set({N,N}, Count, {1,1}),

  lists:foreach(fun(I) ->
                  lists:foreach(fun(J) ->
                                  if I == N and J == N ->
                                    true
                                  else
                                    S = element(1,array:get({I,J},DP)),
                                    C = element(1,array:get({I,J},Count)),
                                    if C > 0 ->
                                      Val = char_to_int(lists:nth(J-1, lists:nth(I-1,board))),
                                        case Val of
                                          'X' ->
                                            ignore;
                                          _ ->
                                            Options = [{I+1,J},{I,J+1},{I+1,J+1}],
                                            lists:foreach(fun({NextI,NextJ}) ->
                                                            if NextI =< N and NextJ =< N then
                                                              {CurrentMax,CurrentCount} = array:get({NextI,NextJ},DP),
                                                              NewVal = S + Val,
                                                              if NewVal > CurrentMax then
                                                                array:set({NextI,NextJ},DP,{NewVal,1}),
                                                                array:set({NextI,NextJ},Count,{C,1})
                                                              else
                                                                if NewVal == CurrentMax then
                                                                  {_,OldCount} = array:get({NextI,NextJ},Count),
                                                                  array:set({NextI,NextJ},Count,{(OldCount + C) rem 1000000007,1})
                                                                else
                                                                  ignore
                                                              end
                                                            else
                                                              ignore
                                                            end
                                                          end, Options)
                                          end
                                    else
                                      ignore
                                    end
                                  end
                                end, lists:seq(N,1,-1))
                end, lists:seq(N,1,-1)),

  {element(1,array:get({1,1},DP)), element(1,array:get({1,1},Count))}.

char_to_int(Char) ->
  try
    list_to_integer([Char])
  catch
    _:_ ->
      Char
  end.