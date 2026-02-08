class Solution:
    def countTargetScores(self, scores: list[int], target: int) -> int:
        first_occurrence_index = self._find_first_ge(scores, target)
        first_occurrence_of_next_val_index = self._find_first_ge(scores, target + 1)

        return first_occurrence_of_next_val_index - first_occurrence_index

    def _find_first_ge(self, arr, target):
        low, high = 0, len(arr)
        while low < high:
            mid = (low + high) // 2
            if arr[mid] < target:
                low = mid + 1
            else:
                high = mid
        return low