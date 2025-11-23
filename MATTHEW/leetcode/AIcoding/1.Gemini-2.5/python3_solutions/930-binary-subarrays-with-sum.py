import collections

class Solution:
    def numSubarraysWithSum(self, nums: list[int], goal: int) -> int:
        count = 0
        current_sum = 0
        prefix_sum_counts = collections.defaultdict(int)
        prefix_sum_counts[0] = 1 

        for num in nums:
            current_sum += num
            count += prefix_sum_counts[current_sum - goal]
            prefix_sum_counts[current_sum] += 1

        return count