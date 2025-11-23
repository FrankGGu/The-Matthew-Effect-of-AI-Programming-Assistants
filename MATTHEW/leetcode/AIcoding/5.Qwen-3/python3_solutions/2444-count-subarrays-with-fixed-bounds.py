class Solution:
    def countSubarrays(self, nums: List[int], k: int) -> int:
        from collections import defaultdict

        count = defaultdict(int)
        res = 0
        curr = 0
        for num in nums:
            if num < k:
                curr += 1
            elif num > k:
                curr -= 1
            else:
                curr = 0
            count[curr] += 1
            res += count[curr - 1]
        return res