from typing import List

class Solution:
    def longest交替子数组(self, nums: List[int], threshold: int) -> int:
        max_len = 0
        n = len(nums)
        for i in range(n):
            if nums[i] > threshold:
                continue
            current_len = 1
            for j in range(i + 1, n):
                if nums[j] > threshold:
                    break
                if (nums[j - 1] % 2) != (nums[j] % 2):
                    current_len += 1
                else:
                    break
            max_len = max(max_len, current_len)
        return max_len