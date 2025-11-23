import collections

class Solution:
    def countBadPairs(self, nums: list[int]) -> int:
        n = len(nums)

        total_pairs = n * (n - 1) // 2

        val_counts = collections.Counter()
        for i in range(n):
            val_counts[nums[i] + i] += 1

        good_pairs_count = 0
        for count in val_counts.values():
            if count >= 2:
                good_pairs_count += count * (count - 1) // 2

        return total_pairs - good_pairs_count