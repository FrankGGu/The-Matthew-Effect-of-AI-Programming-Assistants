class Solution:
    def cut(self, A: List[int], target: int) -> int:
        left, right = 1, max(A)
        while left < right:
            mid = (left + right) // 2
            if sum(max(0, a - mid) for a in A) >= target:
                left = mid + 1
            else:
                right = mid
        return left - 1