class Solution:
    def subArrayRanges(self, nums: list[int]) -> int:
        n = len(nums)

        # Arrays to store indices of previous/next smaller/greater elements
        prev_smaller = [-1] * n
        next_smaller = [n] * n
        prev_greater = [-1] * n
        next_greater = [n] * n

        stack = [] # Monotonic stack for previous smaller and previous greater
        for i in range(n):
            # Calculate prev_smaller[i]
            while stack and nums[stack[-1]] >= nums[i]:
                stack.pop()
            if stack:
                prev_smaller[i] = stack[-1]
            stack.append(i)

        stack = []
        for i in range(n):
            # Calculate prev_greater[i]
            while stack and nums[stack[-1]] <= nums[i]:
                stack.pop()
            if stack:
                prev_greater[i] = stack[-1]
            stack.append(i)

        stack = [] # Monotonic stack for next smaller and next greater (iterate from right to left)
        for i in range(n - 1, -1, -1):
            # Calculate next_smaller[i]
            while stack and nums[stack[-1]] > nums[i]:
                stack.pop()
            if stack:
                next_smaller[i] = stack[-1]
            stack.append(i)

        stack = []
        for i in range(n - 1, -1, -1):
            # Calculate next_greater[i]
            while stack and nums[stack[-1]] < nums[i]:
                stack.pop()
            if stack:
                next_greater[i] = stack[-1]
            stack.append(i)

        total_sum_of_ranges = 0
        for i in range(n):
            # Contribution of nums[i] as a minimum
            # Number of subarrays where nums[i] is the minimum:
            # (i - prev_smaller[i]) * (next_smaller[i] - i)
            # prev_smaller[i] is the index of the first element to its left that is strictly smaller.
            # next_smaller[i] is the index of the first element to its right that is smaller than or equal to.
            # This handles duplicates correctly: if nums[i] == nums[j] for j > i,
            # nums[i] is considered the minimum for ranges ending before j,
            # and nums[j] for ranges starting after i.
            count_as_min = (i - prev_smaller[i]) * (next_smaller[i] - i)

            # Contribution of nums[i] as a maximum
            # Number of subarrays where nums[i] is the maximum:
            # (i - prev_greater[i]) * (next_greater[i] - i)
            # prev_greater[i] is the index of the first element to its left that is strictly greater.
            # next_greater[i] is the index of the first element to its right that is greater than or equal to.
            # Similar logic for duplicates as above.
            count_as_max = (i - prev_greater[i]) * (next_greater[i] - i)

            total_sum_of_ranges += nums[i] * (count_as_max - count_as_min)

        return total_sum_of_ranges