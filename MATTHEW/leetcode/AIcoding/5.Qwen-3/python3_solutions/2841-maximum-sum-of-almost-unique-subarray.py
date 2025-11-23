from typing import List

class Solution:
    def maxSum(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        n = len(nums)
        freq = defaultdict(int)
        current_sum = 0
        max_sum = 0
        left = 0

        for right in range(n):
            current_sum += nums[right]
            freq[nums[right]] += 1

            while freq[nums[right]] > 1:
                current_sum -= nums[left]
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    del freq[nums[left]]
                left += 1

            if len(freq) == k:
                max_sum = max(max_sum, current_sum)

        return max_sum