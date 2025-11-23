import collections

class Solution:
    def destroyTargets(self, nums: list[int], space: int) -> int:
        remainder_counts = collections.defaultdict(int)

        for num in nums:
            remainder_counts[num % space] += 1

        max_destroyed_count = 0
        if remainder_counts: # Check if dictionary is not empty, though constraints imply it won't be
            max_destroyed_count = max(remainder_counts.values())

        min_start_target = float('inf')

        for num in nums:
            if remainder_counts[num % space] == max_destroyed_count:
                min_start_target = min(min_start_target, num)

        return min_start_target