-module(strStr).
-export([strStr/2]).

strStr(Haystack, Needle) ->
  HaystackLen = length(Haystack),
  NeedleLen = length(Needle),
  if NeedleLen == 0 then
    0
  else
    strStr_helper(Haystack, Needle, HaystackLen, NeedleLen, 0)
  end.

strStr_helper(Haystack, Needle, HaystackLen, NeedleLen, StartIndex) ->
  if StartIndex + NeedleLen > HaystackLen then
    -1
  else
    SubString = lists:sublist(Haystack, StartIndex + 1, NeedleLen),
    if SubString == Needle then
      StartIndex
    else
      strStr_helper(Haystack, Needle, HaystackLen, NeedleLen, StartIndex + 1)
    end
  end.