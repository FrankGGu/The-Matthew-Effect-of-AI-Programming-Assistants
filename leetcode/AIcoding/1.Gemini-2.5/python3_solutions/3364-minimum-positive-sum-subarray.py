import bisect

class Solution:
    def minPositiveSumSubarray(self, nums: list[int]) -> int:
        min_positive_sum = float('inf')
        current_prefix_sum = 0

        seen_prefix_sums = [0] 

        for num in nums:
            current_prefix_sum += num

            idx = bisect.bisect_left(seen_prefix_sums, current_prefix_sum)

            if idx > 0:
                prev_prefix_sum = seen_prefix_sums[idx - 1]
                diff = current_prefix_sum - prev_prefix_sum
                min_positive_sum = min(min_positive_sum, diff)

            bisect.insort_left(seen_prefix_sums, current_prefix_sum)

        if min_positive_sum == float('inf'):
            return -1
        else:
            return min_positive_sum