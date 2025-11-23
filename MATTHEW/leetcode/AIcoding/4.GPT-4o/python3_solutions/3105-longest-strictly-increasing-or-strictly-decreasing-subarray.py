class Solution:
    def longestSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 0:
            return 0

        max_length = 1
        current_length = 1
        increasing = True

        for i in range(1, n):
            if nums[i] > nums[i - 1]:
                if not increasing:
                    max_length = max(max_length, current_length)
                    current_length = 2
                    increasing = True
                else:
                    current_length += 1
            elif nums[i] < nums[i - 1]:
                if increasing:
                    max_length = max(max_length, current_length)
                    current_length = 2
                    increasing = False
                else:
                    current_length += 1
            else:
                max_length = max(max_length, current_length)
                current_length = 1
                increasing = True

        max_length = max(max_length, current_length)

        return max_length