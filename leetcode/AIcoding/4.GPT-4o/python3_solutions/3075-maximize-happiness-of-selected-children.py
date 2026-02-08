class Solution:
    def maximizeHappiness(self, numChildren: int, numCandies: int, happiness: List[int]) -> int:
        happiness.sort(reverse=True)
        return sum(happiness[:min(numChildren, numCandies)])