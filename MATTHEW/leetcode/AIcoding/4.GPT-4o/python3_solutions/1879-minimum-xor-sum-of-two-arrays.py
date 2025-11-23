class Solution:
    def minimumXORSum(self, nums1: List[int], nums2: List[int]) -> int:
        n = len(nums1)
        dp = [float('inf')] * (1 << n)
        dp[0] = 0

        for mask in range(1 << n):
            count = bin(mask).count('1')
            if count > len(nums2):
                continue
            for i in range(n):
                if mask & (1 << i) == 0:
                    new_mask = mask | (1 << i)
                    dp[new_mask] = min(dp[new_mask], dp[mask] + (nums1[i] ^ nums2[count]))

        return dp[(1 << n) - 1]