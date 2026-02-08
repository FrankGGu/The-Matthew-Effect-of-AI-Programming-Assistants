class Solution:
    def longestEqualSubarray(self, nums: List[int], k: int) -> int:
        freq = {}
        left = max_length = 0

        for right in range(len(nums)):
            freq[nums[right]] = freq.get(nums[right], 0) + 1

            while (right - left + 1) - max(freq.values()) > k:
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    del freq[nums[left]]
                left += 1

            max_length = max(max_length, right - left + 1)

        return max_length