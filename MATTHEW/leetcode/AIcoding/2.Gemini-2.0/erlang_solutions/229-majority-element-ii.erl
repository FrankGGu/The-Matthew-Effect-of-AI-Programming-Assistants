-module(majority_element_ii).
-export([majority_element/1]).

majority_element(Nums) ->
  {N, _} = lists:foldl(
    fun(Num, {Count1, Count2, Candidate1, Candidate2}) ->
      case Num of
        Candidate1 -> {Count1 + 1, Count2, Candidate1, Candidate2};
        Candidate2 -> {Count1, Count2 + 1, Candidate1, Candidate2};
        _ ->
          if Count1 =:= 0 ->
            {1, Count2, Num, Candidate2};
          else if Count2 =:= 0 ->
            {Count1, 1, Candidate1, Num};
          else
            {Count1 - 1, Count2 - 1, Candidate1, Candidate2}
          end
      end
    end, {0, 0, none, none}, Nums),
  Count1 = lists:foldl(
    fun(Num, Acc) ->
      if Num =:= element(3, N) then
        Acc + 1
      else
        Acc
      end
    end, 0, Nums),
  Count2 = lists:foldl(
    fun(Num, Acc) ->
      if Num =:= element(4, N) then
        Acc + 1
      else
        Acc
      end
    end, 0, Nums),
  Length = length(Nums),
  Result = lists:foldl(
    fun(Element, Acc) ->
      case Element of
        {Value, Count} ->
          if Count > Length div 3 then
            [Value | Acc]
          else
            Acc
          end
      end
    end, [], [{element(3,N), Count1}, {element(4,N), Count2}]),
  lists:reverse(Result).