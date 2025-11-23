class Solution:
    def maximizeMinimum(self, A: List[int], m: int) -> int:
        def canAchieve(x):
            count = 0
            for num in A:
                if num >= x:
                    count += 1
                    if count == m:
                        return True
            return False

        left, right = 0, max(A)
        while left < right:
            mid = (left + right + 1) // 2
            if canAchieve(mid):
                left = mid
            else:
                right = mid - 1
        return left