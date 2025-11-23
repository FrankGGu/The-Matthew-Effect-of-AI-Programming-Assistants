class Solution:
    def minimumLimitOfBalls(self, bagLimits, maxOperations):
        def canAchieve(limit):
            for limit in bagLimits:
                if limit < limit:
                    return False
            return True

        left = 1
        right = max(bagLimits)
        while left < right:
            mid = (left + right) // 2
            if canAchieve(mid):
                right = mid
            else:
                left = mid + 1
        return left