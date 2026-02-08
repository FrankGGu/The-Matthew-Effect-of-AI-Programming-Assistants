class Solution:
    def separateSquares(self, nums: List[int]) -> List[int]:
        return [x for x in nums if x >= 0] + [x for x in nums if x < 0]