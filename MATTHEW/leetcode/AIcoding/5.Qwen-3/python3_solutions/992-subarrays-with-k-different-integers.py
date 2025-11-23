from collections import defaultdict

class Solution:
    def subarraysWithKDistinct(self, nums: List[int], k: int) -> int:
        def atMostK(k):
            count = defaultdict(int)
            left = 0
            res = 0
            for right in range(len(nums)):
                count[nums[right]] += 1
                while len(count) > k:
                    count[nums[left]] -= 1
                    if count[nums[left]] == 0:
                        del count[nums[left]]
                    left += 1
                res += right - left + 1
            return res

        return atMostK(k) - atMostK(k - 1)