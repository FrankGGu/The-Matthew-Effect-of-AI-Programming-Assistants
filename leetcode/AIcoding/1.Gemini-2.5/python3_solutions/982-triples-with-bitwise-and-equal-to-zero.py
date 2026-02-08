class Solution:
    def triplesWithBitwiseANDEqualToZero(self, nums: List[int]) -> int:
        MAX_VAL = 1 << 16

        dp = [0] * MAX_VAL
        for num1 in nums:
            for num2 in nums:
                dp[num1 & num2] += 1

        g = list(dp) 

        for i in range(16):
            for mask in range(MAX_VAL):
                if (mask >> i) & 1:
                    g[mask] += g[mask ^ (1 << i)]

        ans = 0
        for num3 in nums:
            complement_num3 = (MAX_VAL - 1) ^ num3
            ans += g[complement_num3]

        return ans