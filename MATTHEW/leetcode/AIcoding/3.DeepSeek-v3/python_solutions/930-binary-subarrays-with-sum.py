class Solution:
    def numSubarraysWithSum(self, nums: List[int], goal: int) -> int:
        from collections import defaultdict

        prefix_sum = defaultdict(int)
        prefix_sum[0] = 1
        current_sum = 0
        count = 0

        for num in nums:
            current_sum += num
            count += prefix_sum.get(current_sum - goal, 0)
            prefix_sum[current_sum] += 1

        return count