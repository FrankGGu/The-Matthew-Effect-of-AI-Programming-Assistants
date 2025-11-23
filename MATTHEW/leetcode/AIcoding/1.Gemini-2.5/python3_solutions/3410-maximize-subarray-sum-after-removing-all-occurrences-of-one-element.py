class Solution:
    def maxSubArray(self, arr: list[int]) -> int:
        if not arr:
            return 0

        max_so_far = arr[0]
        current_max = arr[0]

        for i in range(1, len(arr)):
            current_max = max(arr[i], current_max + arr[i])
            max_so_far = max(max_so_far, current_max)

        return max_so_far

    def maximizeSubarraySum(self, nums: list[int]) -> int:
        if not nums:
            return 0

        unique_elements = set(nums)

        overall_max_sum = 0

        for x in unique_elements:
            temp_nums = []
            for num in nums:
                if num != x:
                    temp_nums.append(num)

            if not temp_nums:
                max_for_this_x = 0
            else:
                max_for_this_x = self.maxSubArray(temp_nums)

            overall_max_sum = max(overall_max_sum, max_for_this_x)

        return overall_max_sum