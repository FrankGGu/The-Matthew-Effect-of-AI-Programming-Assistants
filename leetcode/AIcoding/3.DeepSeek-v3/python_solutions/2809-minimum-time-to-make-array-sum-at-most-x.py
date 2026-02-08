class Solution:
    def minimumTime(self, nums1: List[int], nums2: List[int], x: int) -> int:
        n = len(nums1)
        pairs = list(zip(nums2, nums1))
        pairs.sort()

        dp = [0] * (n + 1)

        for j in range(1, n + 1):
            b, a = pairs[j - 1]
            for i in range(j, 0, -1):
                dp[i] = max(dp[i], dp[i - 1] + a + b * i)

        sum1 = sum(nums1)
        sum2 = sum(nums2)

        for t in range(0, n + 1):
            if sum1 + sum2 * t - dp[t] <= x:
                return t

        return -1