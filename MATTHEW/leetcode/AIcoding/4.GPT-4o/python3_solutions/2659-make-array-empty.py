class Solution:
    def canBeMadeEmpty(self, A: List[int]) -> bool:
        return sum(A) % 2 == 0 and all(a % 2 == 0 for a in A)