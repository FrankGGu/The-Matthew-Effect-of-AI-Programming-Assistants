import math

class Solution:
    def minimumXORSum(self, nums1: list[int], nums2: list[int]) -> int:
        n = len(nums1)

        dp = [math.inf] * (1 << n)

        dp[0] = 0

        for mask in range(1 << n):
            if dp[mask] == math.inf:
                continue

            k = bin(mask).count('1')

            if k == n:
                continue

            for j in range(n):
                if not (mask & (1 << j)):
                    new_mask = mask | (1 << j)
                    current_xor_sum = dp[mask] + (nums1[k] ^ nums2[j])
                    dp[new_mask] = min(dp[new_mask], current_xor_sum)

        return dp[(1 << n) - 1]