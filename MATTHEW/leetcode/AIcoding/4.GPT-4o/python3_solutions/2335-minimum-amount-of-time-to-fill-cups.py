class Solution:
    def fillCups(self, cups: List[int]) -> int:
        return max((sum(cups) + 2) // 3, max(cups))