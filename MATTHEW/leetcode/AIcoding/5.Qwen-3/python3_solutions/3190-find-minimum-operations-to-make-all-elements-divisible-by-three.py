class Solution:
    def minimumOperationsNumbers(self, nums: List[int]) -> int:
        count = [0, 0, 0]
        for num in nums:
            mod = num % 3
            count[mod] += 1
        return min(count)