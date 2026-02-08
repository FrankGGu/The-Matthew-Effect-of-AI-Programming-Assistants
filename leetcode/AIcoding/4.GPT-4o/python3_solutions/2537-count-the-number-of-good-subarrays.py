class Solution:
    def countGood(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = 0
        left = 0
        freq = defaultdict(int)
        pairs = 0

        for right in range(len(nums)):
            freq[nums[right]] += 1
            pairs += freq[nums[right]] - 1

            while pairs >= k:
                freq[nums[left]] -= 1
                pairs -= freq[nums[left]]  # Remove pairs contributed by nums[left]
                left += 1

            count += left

        return count