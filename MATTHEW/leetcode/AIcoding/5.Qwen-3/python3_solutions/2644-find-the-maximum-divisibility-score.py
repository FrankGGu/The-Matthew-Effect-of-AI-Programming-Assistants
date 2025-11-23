class Solution:
    def maxDivisibilityScore(self, nums: List[int], div: int) -> int:
        max_count = -1
        result = 0
        for num in nums:
            count = 0
            if num % div == 0:
                count += 1
            if count > max_count:
                max_count = count
                result = num
        return result