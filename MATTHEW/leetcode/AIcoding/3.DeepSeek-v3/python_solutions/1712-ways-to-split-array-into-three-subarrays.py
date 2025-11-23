class Solution:
    def waysToSplit(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i+1] = prefix[i] + nums[i]

        res = 0
        j = k = 0
        for i in range(1, n):
            j = max(j, i + 1)
            while j < n and prefix[j] - prefix[i] < prefix[i]:
                j += 1

            k = max(k, j)
            while k < n and prefix[k] - prefix[i] <= prefix[-1] - prefix[k]:
                k += 1

            res = (res + k - j) % MOD

        return res