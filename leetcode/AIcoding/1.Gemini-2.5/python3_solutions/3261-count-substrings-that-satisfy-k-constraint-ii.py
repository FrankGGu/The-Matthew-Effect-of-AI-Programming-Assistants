from collections import defaultdict

class Solution:
    def subarraysWithKDistinct(self, nums: list[int], k: int) -> int:
        return self._count_at_most_k(nums, k) - self._count_at_most_k(nums, k - 1)

    def _count_at_most_k(self, nums: list[int], k: int) -> int:
        if k < 0:
            return 0

        n = len(nums)
        left = 0
        freq = defaultdict(int)
        distinct_count = 0
        ans = 0

        for right in range(n):
            if freq[nums[right]] == 0:
                distinct_count += 1
            freq[nums[right]] += 1

            while distinct_count > k:
                freq[nums[left]] -= 1
                if freq[nums[left]] == 0:
                    distinct_count -= 1
                left += 1

            ans += (right - left + 1)

        return ans