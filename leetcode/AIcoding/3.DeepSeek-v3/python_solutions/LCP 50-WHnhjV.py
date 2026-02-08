class Solution:
    def giveGem(self, gem: List[int], operations: List[List[int]]) -> int:
        for x, y in operations:
            give = gem[x] // 2
            gem[x] -= give
            gem[y] += give
        return max(gem) - min(gem)