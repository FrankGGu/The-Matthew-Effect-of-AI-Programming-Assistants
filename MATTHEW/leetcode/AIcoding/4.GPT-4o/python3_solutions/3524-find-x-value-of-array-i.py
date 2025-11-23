class Solution:
    def findX(self, nums: List[int], x: int) -> int:
        return sum(1 for num in nums if num == x)