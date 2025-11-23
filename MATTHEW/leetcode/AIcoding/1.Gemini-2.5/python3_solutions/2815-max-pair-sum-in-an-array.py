from collections import defaultdict

class Solution:
    def max_digit(self, n: int) -> int:
        max_d = 0
        while n > 0:
            max_d = max(max_d, n % 10)
            n //= 10
        return max_d

    def maxSum(self, nums: list[int]) -> int:
        grouped_nums = defaultdict(list)

        for num in nums:
            max_d = self.max_digit(num)
            grouped_nums[max_d].append(num)

        max_pair_sum = -1

        for max_d in range(10):
            current_group = grouped_nums[max_d]
            if len(current_group) >= 2:
                current_group.sort(reverse=True)
                max_pair_sum = max(max_pair_sum, current_group[0] + current_group[1])

        return max_pair_sum