class Solution:
    def maxNonOverlapping(self, nums: List[int], target: int) -> int:
        prefix_sum = 0
        sum_set = {0}
        count = 0

        for num in nums:
            prefix_sum += num
            if (prefix_sum - target) in sum_set:
                count += 1
                prefix_sum = 0
                sum_set = {0}
            sum_set.add(prefix_sum)

        return count