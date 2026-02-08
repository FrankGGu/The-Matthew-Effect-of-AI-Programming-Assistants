class Solution:
    def findMinimumImpossibleOR(self, A: List[int]) -> int:
        seen = set(A)
        for i in range(1, 10**6 + 2):
            if i not in seen:
                return i