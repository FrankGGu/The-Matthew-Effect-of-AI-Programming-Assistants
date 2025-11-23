class Solution:
    def findClosestSubarray(self, nums: List[int], k: int) -> List[int]:
        closest = float('inf')
        best_l, best_r = -1, -1
        n = len(nums)

        for l in range(n):
            current_or = 0
            for r in range(l, n):
                current_or |= nums[r]
                if abs(current_or - k) < abs(closest - k) or (abs(current_or - k) == abs(closest - k) and (best_r - best_l > r - l)):
                    closest = current_or
                    best_l, best_r = l, r

        return nums[best_l:best_r + 1]