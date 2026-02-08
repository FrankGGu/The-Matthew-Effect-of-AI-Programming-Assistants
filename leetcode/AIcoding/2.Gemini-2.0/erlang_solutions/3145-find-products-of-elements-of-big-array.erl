-module(solution).
-export([product_except_self/1]).

product_except_self(Nums) ->
  N = length(Nums),
  {Prefix, Suffix} = lists:foldl(
    fun(Num, {PrevPrefix, PrevSuffix}) ->
      {PrevPrefix ++ [case PrevPrefix of [] -> 1; _ -> lists:last(PrevPrefix) * hd(lists:reverse(Nums -- [Num])) end],
       [case PrevSuffix of [] -> 1; _ -> hd(PrevSuffix) * Num end] ++ PrevSuffix}
    end,
    {[], []},
    Nums),

  lists:map(
    fun(I) ->
      case I of
        1 ->
          lists:nth(1, Suffix);
        N ->
          lists:nth(N - 1, Prefix);
        _ ->
          lists:nth(I - 1, Prefix) * lists:nth(N - I, Suffix)
      end
    end,
    lists:seq(1, N)
  ).