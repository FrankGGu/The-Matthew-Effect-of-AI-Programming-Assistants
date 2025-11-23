class Solution:
    def waysToMakeFair(self, nums: List[int]) -> int:
        n = len(nums)
        even_sum_right = 0
        odd_sum_right = 0
        for i in range(n):
            if i % 2 == 0:
                even_sum_right += nums[i]
            else:
                odd_sum_right += nums[i]

        even_sum_left = 0
        odd_sum_left = 0
        count = 0

        for i in range(n):
            if i % 2 == 0:
                even_sum_right -= nums[i]
                if even_sum_left + odd_sum_right == odd_sum_left + even_sum_right:
                    count += 1
                even_sum_left += nums[i]
            else:
                odd_sum_right -= nums[i]
                if even_sum_left + odd_sum_right == odd_sum_left + even_sum_right:
                    count += 1
                odd_sum_left += nums[i]

        return count