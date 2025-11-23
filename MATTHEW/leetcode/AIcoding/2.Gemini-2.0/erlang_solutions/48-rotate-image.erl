-module(rotate_image).
-export([rotate/1]).

rotate(Matrix) ->
  N = length(Matrix),
  rotate_helper(Matrix, N).

rotate_helper(Matrix, N) ->
  lists:foldl(
    fun(I, Acc) ->
      lists:foldl(
        fun(J, Acc2) ->
          {Acc3, _} = lists:foldl(
            fun(K, {Acc4, Done}) ->
              if K == 0 ->
                {Acc4, Done};
              true ->
                if Done == true ->
                  {Acc4, Done};
                true ->
                  Temp = lists:nth(I, lists:nth(J, Acc4)),

                  {NewAcc, _} = lists:foldl(
                    fun(L, {Acc5, Done2}) ->
                      if L == 0 ->
                         {Acc5, Done2};
                      true ->
                        if Done2 == true ->
                          {Acc5, Done2};
                        true ->
                          NextI = J,
                          NextJ = N - 1 - I,

                          NextTemp = lists:nth(NextI, lists:nth(NextJ, Acc5)),
                          NewMatrix = lists:update(NextJ, lists:update(NextI, Temp, lists:nth(NextJ,Acc5)), Acc5),
                          {NewMatrix, true}
                        end
                    end, {Acc4, false}, lists:seq(1,1)),
                  {NewAcc, true}
                end
            end, {Acc2, false}, lists:seq(1,1)),
          Acc3
        end, Acc, lists:seq(1, N div 2)
      )
    end, Matrix, lists:seq(1, (N + 1) div 2)).