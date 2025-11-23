class Solution:
    def numSubarraysWithKGood(nums, k):
        from collections import defaultdict

        count = defaultdict(int)
        count[0] = 1
        res = 0
        curr = 0

        for num in nums:
            curr += num
            res += count[curr - k]
            count[curr] += 1

        return res