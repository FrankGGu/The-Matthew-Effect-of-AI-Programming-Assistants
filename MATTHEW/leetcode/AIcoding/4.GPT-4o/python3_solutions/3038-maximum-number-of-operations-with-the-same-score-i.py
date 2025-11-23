class Solution:
    def maximumOperations(self, nums: List[int], target: int) -> int:
        count = 0
        for num in nums:
            if num <= target:
                target -= num
                count += 1
        return count