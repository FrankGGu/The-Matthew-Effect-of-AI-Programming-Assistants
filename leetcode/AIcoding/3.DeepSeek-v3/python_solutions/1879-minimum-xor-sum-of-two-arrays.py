class Solution:
    def minimumXORSum(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        for mask in range(1 << n):
            cnt = bin(mask).count('1')
            for i in range(n):
                if not (mask & (1 << i)):
                    next_mask = mask | (1 << i)
                    dp[next_mask] = min(dp[next_mask], dp[mask] + (nums1[cnt] ^ nums2[i]))

        return dp[(1 << n) - 1]