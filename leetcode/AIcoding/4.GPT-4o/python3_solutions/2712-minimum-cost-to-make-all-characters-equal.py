class Solution:
    def minimumCost(self, s: str) -> int:
        return min(sum(i != c for i in s) for c in set(s))