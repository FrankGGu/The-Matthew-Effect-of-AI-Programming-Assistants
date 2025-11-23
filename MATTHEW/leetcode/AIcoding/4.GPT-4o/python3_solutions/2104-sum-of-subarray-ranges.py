class Solution:
    def subArrayRanges(self, nums: List[int]) -> int:
        n = len(nums)
        total_range_sum = 0

        for i in range(n):
            max_stack = []
            min_stack = []
            for j in range(i, n):
                while max_stack and nums[max_stack[-1]] <= nums[j]:
                    max_stack.pop()
                max_stack.append(j)

                while min_stack and nums[min_stack[-1]] >= nums[j]:
                    min_stack.pop()
                min_stack.append(j)

                total_range_sum += nums[max_stack[-1]] - nums[min_stack[-1]]

        return total_range_sum