class Solution:
    def giveGem(self, gem: list[int], operations: list[list[int]]) -> int:
        for i, j in operations:
            give = gem[i] // 2
            gem[i] -= give
            gem[j] += give
        return max(gem) - min(gem)