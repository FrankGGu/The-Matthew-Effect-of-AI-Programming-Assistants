-module(black_box_reflection).
-export([reflect_ray/2]).

reflect_ray(N, K) ->
  reflect_ray_helper(N, K, 0, 0, 1, 0, []).

reflect_ray_helper(N, K, X, Y, Dx, Dy, Path) when length(Path) > 4*N ->
  lists:reverse(Path);
reflect_ray_helper(N, K, X, Y, Dx, Dy, Path) ->
  case {X + Dx, Y + Dy} of
    {NX, _} when NX < 0 ->
      reflect_ray_helper(N, K, 0, Y, -Dx, Dy, [0|Path]);
    {NX, _} when NX > N ->
      reflect_ray_helper(N, K, N, Y, -Dx, Dy, [N|Path]);
    {_, NY} when NY < 0 ->
      reflect_ray_helper(N, K, X, 0, Dx, -Dy, [N+X|Path]);
    {_, NY} when NY > N ->
      reflect_ray_helper(N, K, X, N, Dx, -Dy, [3*N-X|Path]);
    {NX, NY} ->
      reflect_ray_helper(N, K, NX, NY, Dx, Dy, Path)
  end.