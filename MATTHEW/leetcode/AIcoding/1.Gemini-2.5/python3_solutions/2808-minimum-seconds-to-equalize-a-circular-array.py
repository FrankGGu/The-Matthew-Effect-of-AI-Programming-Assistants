import collections

class Solution:
    def minimumSeconds(self, nums: list[int]) -> int:
        n = len(nums)
        val_indices = collections.defaultdict(list)
        for i, num in enumerate(nums):
            val_indices[num].append(i)

        min_seconds = n 

        for val in val_indices:
            indices = val_indices[val]

            max_dist_between_occurrences = 0

            for i in range(len(indices) - 1):
                dist = indices[i+1] - indices[i]
                max_dist_between_occurrences = max(max_dist_between_occurrences, dist)

            circular_dist = (n - indices[-1]) + indices[0]
            max_dist_between_occurrences = max(max_dist_between_occurrences, circular_dist)

            current_seconds = max_dist_between_occurrences // 2
            min_seconds = min(min_seconds, current_seconds)

        return min_seconds