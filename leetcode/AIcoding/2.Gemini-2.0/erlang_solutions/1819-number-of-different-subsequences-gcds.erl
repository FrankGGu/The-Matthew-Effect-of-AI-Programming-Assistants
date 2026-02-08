-module(number_of_different_subsequences_gcds).
-export([number_different_subsequences_gcds/1]).

number_different_subsequences_gcds(Nums) ->
  MaxNum = lists:max(Nums),
  Has = lists:foldl(fun(N, Acc) -> Acc#{N => true} end, #{}, Nums),

  lists:foldl(fun(I, Acc) ->
                case check_gcd(I, Nums, Has, MaxNum) of
                  true -> Acc + 1;
                  false -> Acc
                end
              end, 0, lists:seq(1, MaxNum)).

check_gcd(I, Nums, Has, MaxNum) ->
  case maps:is_key(Has, I) of
    true -> true;
    false ->
      First = find_first_multiple(I, Nums, MaxNum),
      case First of
        none -> false;
        _ ->
          GCD = lists:foldl(fun(N, A) -> gcd(N, A) end, First, find_other_multiples(I, Nums, MaxNum, First)),
          GCD == I
      end
  end.

find_first_multiple(I, Nums, MaxNum) ->
  lists:foldl(fun(N, Acc) ->
                case N rem I == 0 of
                  true ->
                    case Acc of
                      none -> N;
                      _ -> Acc
                    end;
                  false -> Acc
                end
              end, none, Nums).

find_other_multiples(I, Nums, MaxNum, First) ->
  lists:foldl(fun(N, Acc) ->
                case N rem I == 0 andalso N /= First of
                  true -> [N|Acc];
                  false -> Acc
                end
              end, [], Nums).

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).