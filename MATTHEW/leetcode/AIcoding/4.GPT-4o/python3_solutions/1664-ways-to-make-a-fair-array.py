class Solution:
    def waysToMakeFair(self, nums: List[int]) -> int:
        n = len(nums)
        odd_sum = sum(nums[i] for i in range(1, n, 2))
        even_sum = sum(nums[i] for i in range(0, n, 2))

        count = 0
        odd_prefix = 0
        even_prefix = 0

        for i in range(n):
            if i % 2 == 0:
                even_sum -= nums[i]
            else:
                odd_sum -= nums[i]

            if odd_prefix + even_sum == even_prefix + odd_sum:
                count += 1

            if i % 2 == 0:
                even_prefix += nums[i]
            else:
                odd_prefix += nums[i]

        return count