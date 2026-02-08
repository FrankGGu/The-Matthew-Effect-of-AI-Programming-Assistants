class Solution:
    def minPositiveSumSubarray(self, nums: List[int]) -> int:
        min_sum = float('inf')
        current_sum = 0
        prefix_sums = [0]
        min_prefix = 0

        for num in nums:
            current_sum += num
            if current_sum - min_prefix > 0:
                min_sum = min(min_sum, current_sum - min_prefix)
            min_prefix = min(min_prefix, current_sum)
            prefix_sums.append(current_sum)

        return min_sum if min_sum != float('inf') else -1