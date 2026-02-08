class Solution:
    def maxSumTwoNoOverlap(self, nums: List[int], firstLen: int, secondLen: int) -> int:
        n = len(nums)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] + nums[i]

        def max_sum(L, M):
            max_L = 0
            res = 0
            for i in range(L + M, n + 1):
                max_L = max(max_L, prefix[i - M] - prefix[i - M - L])
                current_M = prefix[i] - prefix[i - M]
                res = max(res, max_L + current_M)
            return res

        return max(max_sum(firstLen, secondLen), max_sum(secondLen, firstLen))