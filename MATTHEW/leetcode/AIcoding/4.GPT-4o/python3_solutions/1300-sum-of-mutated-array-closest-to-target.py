class Solution:
    def findBestValue(self, arr: List[int], target: int) -> int:
        left, right = 0, max(arr)
        while left < right:
            mid = (left + right) // 2
            if sum(min(x, mid) for x in arr) < target:
                left = mid + 1
            else:
                right = mid
        if sum(min(x, left) for x in arr) <= target:
            return left
        return left - 1 if abs(sum(min(x, left - 1) for x in arr) - target) <= abs(sum(min(x, left) for x in arr) - target) else left - 1