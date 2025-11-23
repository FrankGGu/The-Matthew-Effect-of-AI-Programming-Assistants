-module(skyline).
-export([get_skyline/1]).

get_skyline(Buildings) ->
  get_skyline(Buildings, []).

get_skyline([], Acc) ->
  lists:reverse(Acc);
get_skyline([Building | Rest], Acc) ->
  get_skyline(Rest, merge_building(Building, Acc)).

merge_building([L, R, H], []) ->
  [[L, H], [R, 0]];
merge_building([L, R, H], [[LastR, LastH] | _] = Acc) ->
  case L < LastR of
    true ->
      merge_building_overlap([L, R, H], Acc);
    false ->
      [[L, H], [R, 0] | Acc]
  end.

merge_building_overlap([L, R, H], [[LastR, LastH] | Rest] = Acc) ->
  case H > LastH of
    true ->
      case R < LastR of
        true ->
          [[L, H], [R, LastH] | Acc];
        false ->
          case R =:= LastR of
            true ->
              [[L, H] | Rest];
            false ->
              [[L, H], [LastR, LastH], [R, 0] | Rest]
          end
      end;
    false ->
       case R < LastR of
         true ->
           Acc;
         false ->
           case R =:= LastR of
             true ->
              Acc;
             false ->
               [[LastR, LastH], [R, 0] | Rest]
           end
       end
  end.