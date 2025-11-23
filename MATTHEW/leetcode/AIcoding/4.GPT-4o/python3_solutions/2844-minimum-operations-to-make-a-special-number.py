class Solution:
    def minimumOperations(self, nums: List[int]) -> int:
        odd = sum(1 for x in nums if x % 2 != 0)
        even = sum(1 for x in nums if x % 2 == 0)
        return min(odd, even)