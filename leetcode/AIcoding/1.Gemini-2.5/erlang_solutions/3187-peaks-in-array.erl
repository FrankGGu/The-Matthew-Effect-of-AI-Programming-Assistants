-module(solution).
-export([findPeaks/1]).

findPeaks(Nums) ->
    find_peaks_internal(Nums, 0, []).

find_peaks_internal([], _Idx, Acc) -> lists:reverse(Acc);
find_peaks_internal([_], _Idx, Acc) -> lists:reverse(Acc);
find_peaks_internal([_,_], _Idx, Acc) -> lists:reverse(Acc);

find_peaks_internal([Prev, Current, Next | Rest], Idx, Acc) ->
    % The potential peak element is 'Current', which is at index Idx + 1.
    PeakCandidateIdx = Idx + 1,
    if
        Prev < Current andalso Current > Next ->
            % 'Current' is a peak. Add its index to the accumulator.
            find_peaks_internal([Current, Next | Rest], PeakCandidateIdx, [PeakCandidateIdx | Acc]);
        true ->
            % 'Current' is not a peak. Continue to the next window.
            find_peaks_internal([Current, Next | Rest], PeakCandidateIdx, Acc)
    end.