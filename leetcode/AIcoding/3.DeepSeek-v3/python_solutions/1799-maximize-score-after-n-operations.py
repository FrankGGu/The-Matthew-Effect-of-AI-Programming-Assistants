class Solution:
    def maxScore(self, nums: List[int]) -> int:
        n = len(nums)
        dp = [0] * (1 << n)

        for mask in range(1 << n):
            cnt = bin(mask).count('1')
            if cnt % 2 != 0:
                continue
            k = cnt // 2 + 1
            for i in range(n):
                if not (mask & (1 << i)):
                    continue
                for j in range(i + 1, n):
                    if not (mask & (1 << j)):
                        continue
                    new_mask = mask ^ (1 << i) ^ (1 << j)
                    dp[mask] = max(dp[mask], dp[new_mask] + k * math.gcd(nums[i], nums[j]))

        return dp[(1 << n) - 1]