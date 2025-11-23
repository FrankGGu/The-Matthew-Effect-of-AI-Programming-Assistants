-module(mountain_array).
-export([find_in_mountain_array/2]).

find_in_mountain_array(Target, MountainArr) ->
  Length = mountain_array:length(MountainArr),
  PeakIndex = find_peak_index(0, Length - 1, MountainArr),
  case binary_search(0, PeakIndex, Target, MountainArr, true) of
    -1 -> binary_search(PeakIndex + 1, Length - 1, Target, MountainArr, false);
    Index -> Index
  end.

find_peak_index(Low, High, MountainArr) ->
  if Low == High then
    Low
  else
    Mid = Low + (High - Low) div 2,
    MidVal = mountain_array:get(MountainArr, Mid),
    NextVal = mountain_array:get(MountainArr, Mid + 1),
    if MidVal < NextVal then
      find_peak_index(Mid + 1, High, MountainArr)
    else
      find_peak_index(Low, Mid, MountainArr)
    end
  end.

binary_search(Low, High, Target, MountainArr, IsAscending) ->
  if Low > High then
    -1
  else
    Mid = Low + (High - Low) div 2,
    MidVal = mountain_array:get(MountainArr, Mid),
    case Target of
      MidVal -> Mid;
      _ ->
        if IsAscending then
          if Target < MidVal then
            binary_search(Low, Mid - 1, Target, MountainArr, IsAscending)
          else
            binary_search(Mid + 1, High, Target, MountainArr, IsAscending)
          end
        else
          if Target < MidVal then
            binary_search(Mid + 1, High, Target, MountainArr, IsAscending)
          else
            binary_search(Low, Mid - 1, Target, MountainArr, IsAscending)
          end
        end
    end
  end.