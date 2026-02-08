-module(number_of_strings).
-export([number_of_strings/1]).

number_of_strings(N) ->
  Total = math:pow(26, N),
  NoL = math:pow(25, N),
  NoE = math:pow(25, N),
  NoT = math:pow(25, N),
  NoLE = math:pow(24, N),
  NoLT = math:pow(24, N),
  NoET = math:pow(24, N),
  NoLET = math:pow(23, N),

  round(Total - NoL - NoE - NoT + NoLE + NoLT + NoET - NoLET) rem 1000000007.