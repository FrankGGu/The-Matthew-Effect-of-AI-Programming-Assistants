class Solution:
    def maxKDivisibleComponents(self, nums: List[int], k: int) -> int:
        count = 0
        for num in nums:
            if num % k == 0:
                count += 1
        return count