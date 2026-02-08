class Solution:
    def minEqualSum(self, arr1: List[int], arr2: List[int]) -> int:
        sum1, sum2 = sum(arr1), sum(arr2)
        total = sum1 + sum2

        if total % 2 != 0:
            return -1

        target = total // 2

        def canAchieveTarget(arr, target):
            n = len(arr)
            dp = [False] * (target + 1)
            dp[0] = True

            for num in arr:
                for j in range(target, num - 1, -1):
                    dp[j] = dp[j] or dp[j - num]

            return dp[target]

        return abs(sum1 - target) if canAchieveTarget(arr1, target) or canAchieveTarget(arr2, target) else -1