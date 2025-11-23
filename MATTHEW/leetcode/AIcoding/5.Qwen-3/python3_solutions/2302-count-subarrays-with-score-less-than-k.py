class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        prefix_sum = 0
        count = 0
        sum_counts = defaultdict(int)
        sum_counts[0] = 1

        for num in nums:
            prefix_sum += num
            count += sum_counts[prefix_sum - k]
            sum_counts[prefix_sum] += 1

        return count