-module(solution).
-export([findLatestStep/3]).

-include_lib("stdlib/include/array.hrl").

findLatestStep(N, Arr, M) ->
    % LenAtStart[i] stores the length of the group of 1s starting at index i.
    % LenAtEnd[i] stores the length of the group of 1s ending at index i.
    % Both are initialized to 0.
    LenAtStart = array:new(N, {default, 0}),
    LenAtEnd = array:new(N, {default, 0}),

    % CountM stores the number of groups of size M.
    CountM = 0,

    % Ans stores the latest step number. Initialize to -1.
    Ans = -1,

    % Iterate through the Arr (0-indexed)
    % Step number is (Idx + 1)
    lists:foldl(
        fun(ArrVal, Acc) ->
            #{
                len_at_start := CurrentLenAtStart,
                len_at_end := CurrentLenAtEnd,
                count_m := CurrentCountM,
                ans := CurrentAns,
                idx := Idx
            } = Acc,

            Pos = ArrVal - 1, % Convert 1-based value from Arr to 0-based index

            LeftLen = if Pos > 0 -> array:get(Pos - 1, CurrentLenAtEnd);
                        true -> 0
                      end,

            RightLen = if Pos < N - 1 -> array:get(Pos + 1, CurrentLenAtStart);
                         true -> 0
                       end,

            NewCountM = CurrentCountM, % Start with current count, adjust below

            % If a group of size M is about to be merged/destroyed, decrement CountM
            NewCountM1 = if LeftLen == M -> NewCountM - 1;
                           true -> NewCountM
                         end,

            NewCountM2 = if RightLen == M -> NewCountM1 - 1;
                           true -> NewCountM1
                         end,

            NewLen = LeftLen + 1 + RightLen,

            StartIdx = Pos - LeftLen,
            EndIdx = Pos + RightLen,

            UpdatedLenAtStart = array:set(StartIdx, NewLen, CurrentLenAtStart),
            UpdatedLenAtEnd = array:set(EndIdx, NewLen, CurrentLenAtEnd),

            % If a new group of size M is formed, increment CountM
            FinalCountM = if NewLen == M -> NewCountM2 + 1;
                            true -> NewCountM2
                          end,

            % If there's at least one group of size M, update Ans
            FinalAns = if FinalCountM > 0 -> Idx + 1;
                         true -> CurrentAns
                       end,

            #{
                len_at_start => UpdatedLenAtStart,
                len_at_end => UpdatedLenAtEnd,
                count_m => FinalCountM,
                ans => FinalAns,
                idx => Idx + 1
            }
        end,
        #{
            len_at_start => LenAtStart,
            len_at_end => LenAtEnd,
            count_m => CountM,
            ans => Ans,
            idx => 0 % Current 0-indexed step for Arr
        },
        Arr
    )#{ans := ResultAns}.