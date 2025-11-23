class Solution:
    def giveGem(self, gem: List[int], operations: List[List[int]]) -> int:
        for i, j in operations:
            gem[j] += gem[i] // 2
            gem[i] -= gem[i] // 2
        return max(gem) - min(gem)