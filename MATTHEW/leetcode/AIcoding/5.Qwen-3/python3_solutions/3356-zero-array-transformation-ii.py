class Solution:
    def isPossible(self, nums: List[int], queries: List[int], k: int) -> bool:
        from collections import defaultdict

        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        diff = [0] * (n + 2)
        for q in queries:
            a, b, c = q
            diff[a] += c
            diff[b + 1] -= c

        for i in range(1, n + 1):
            diff[i] += diff[i - 1]

        for i in range(n):
            if diff[i] > k:
                return False

        return True