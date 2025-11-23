from collections import defaultdict

class Solution:
    def destroyTargets(self, nums: list[int], space: int) -> int:
        mod_counts = defaultdict(int)
        for num in nums:
            mod_counts[num % space] += 1

        max_count = 0
        for count in mod_counts.values():
            max_count = max(max_count, count)

        min_target = float('inf')
        for num in nums:
            if mod_counts[num % space] == max_count:
                min_target = min(min_target, num)

        return min_target