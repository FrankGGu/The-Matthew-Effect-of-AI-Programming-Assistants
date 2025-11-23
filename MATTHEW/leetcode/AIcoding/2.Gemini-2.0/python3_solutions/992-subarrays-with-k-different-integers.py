from collections import defaultdict

class Solution:
    def subarraysWithKDistinct(self, nums: list[int], k: int) -> int:
        def at_most_k_distinct(nums, k):
            count = defaultdict(int)
            left = 0
            res = 0
            distinct_count = 0
            for right, num in enumerate(nums):
                if count[num] == 0:
                    distinct_count += 1
                count[num] += 1

                while distinct_count > k:
                    count[nums[left]] -= 1
                    if count[nums[left]] == 0:
                        distinct_count -= 1
                    left += 1
                res += right - left + 1
            return res

        return at_most_k_distinct(nums, k) - at_most_k_distinct(nums, k - 1)