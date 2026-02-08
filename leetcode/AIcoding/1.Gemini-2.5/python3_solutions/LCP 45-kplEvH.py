from collections import defaultdict

class Solution:
    def longestEqualSubarray(self, nums: list[int], k: int) -> int:
        left = 0
        max_freq_in_window = 0
        ans = 0
        freq = defaultdict(int)

        for right in range(len(nums)):
            freq[nums[right]] += 1
            max_freq_in_window = max(max_freq_in_window, freq[nums[right]])

            while (right - left + 1) - max_freq_in_window > k:
                freq[nums[left]] -= 1
                left += 1

            ans = max(ans, max_freq_in_window)

        return ans