class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        n = len(nums)
        res = 0
        left = 0
        max_freq = 0
        freq = {}

        for right in range(n):
            num = nums[right]
            freq[num] = freq.get(num, 0) + 1
            max_freq = max(max_freq, freq[num])

            while (right - left + 1) - max_freq > k:
                left_num = nums[left]
                freq[left_num] -= 1
                left += 1

            res += right - left + 1

        return res