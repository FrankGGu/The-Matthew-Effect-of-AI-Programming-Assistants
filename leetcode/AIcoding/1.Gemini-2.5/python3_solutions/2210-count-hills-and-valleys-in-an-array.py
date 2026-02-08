class Solution:
    def countHillValley(self, nums: list[int]) -> int:
        n = len(nums)
        if n < 3:
            return 0

        count = 0

        for i in range(1, n - 1):
            curr_val = nums[i]

            left_ptr = i - 1
            while left_ptr >= 0 and nums[left_ptr] == curr_val:
                left_ptr -= 1

            if left_ptr < 0:
                continue
            left_val = nums[left_ptr]

            right_ptr = i + 1
            while right_ptr < n and nums[right_ptr] == curr_val:
                right_ptr += 1

            if right_ptr >= n:
                continue
            right_val = nums[right_ptr]

            if (left_val < curr_val and curr_val > right_val) or \
               (left_val > curr_val and curr_val < right_val):
                count += 1

        return count