-module(find_latest_group).
-export([find_latest_group/2]).

find_latest_group(Arr, M) ->
  N = length(Arr),
  Parents = array:new(N + 2, {fixed, 0}),
  Sizes = array:new(N + 2, {fixed, 0}),
  Res = -1,

  find(X, Parents) ->
    case array:get(X, Parents) of
      0 -> X;
      P -> find(P, Parents)
    end
  end,

  union(X, Y, Parents, Sizes) ->
    RootX = find(X, Parents),
    RootY = find(Y, Parents),
    if RootX == RootY then
      {Parents, Sizes}
    else
      SizeX = array:get(RootX, Sizes),
      SizeY = array:get(RootY, Sizes),
      if SizeX < SizeY then
        array:set(RootX, Parents, RootY),
        array:set(RootY, Sizes, SizeX + SizeY),
        {Parents, Sizes}
      else
        array:set(RootY, Parents, RootX),
        array:set(RootX, Sizes, SizeX + SizeY),
        {Parents, Sizes}
      end
    end
  end,

  process_arr(Arr, M, Parents, Sizes, Res, I) ->
    case Arr of
      [] -> Res;
      [A | Rest] ->
        array:set(A, Parents, 0, Parents),
        array:set(A, Sizes, 1, Sizes),

        {NewParents, NewSizes} = 
          case array:get(A - 1, Parents) of
            0 -> {Parents, Sizes};
            _ -> union(A, A - 1, Parents, Sizes)
          end,

        {NewParents2, NewSizes2} = 
          case array:get(A + 1, NewParents) of
            0 -> {NewParents, NewSizes};
            _ -> union(A, A + 1, NewParents, NewSizes)
          end,

        RootA = find(A, NewParents2),
        if array:get(RootA, NewSizes2) == M then
          process_arr(Rest, M, NewParents2, NewSizes2, I, I + 1)
        else
          process_arr(Rest, M, NewParents2, NewSizes2, Res, I + 1)
        end
    end
  end,

  process_arr(Arr, M, Parents, Sizes, Res, 1).