class Solution:
    def getMinDistance(self, nums: List[int], target: int, start: int) -> int:
        min_dist = float('inf')
        for i, num in enumerate(nums):
            if num == target:
                dist = abs(i - start)
                if dist < min_dist:
                    min_dist = dist
        return min_dist