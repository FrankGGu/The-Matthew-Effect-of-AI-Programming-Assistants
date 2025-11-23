class Solution:
    def maximizeFrequency(self, nums: List[int], k: int) -> int:
        from collections import Counter

        count = Counter(nums)
        unique_nums = sorted(count.keys())
        max_freq = 0
        left = 0
        current_operations = 0

        for right in range(len(unique_nums)):
            current_operations += (unique_nums[right] - unique_nums[right - 1]) * (right - left) if right > 0 else 0

            while current_operations > k:
                current_operations -= unique_nums[right] - unique_nums[left]
                left += 1

            max_freq = max(max_freq, right - left + 1)

        return max_freq + (k - current_operations) // (left - 1) if left > 0 else max_freq