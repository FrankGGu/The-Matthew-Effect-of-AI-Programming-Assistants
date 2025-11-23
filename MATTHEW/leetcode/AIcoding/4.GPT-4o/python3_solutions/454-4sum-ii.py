class Solution:
    def fourSumCount(self, A: List[int], B: List[int], C: List[int], D: List[int]) -> int:
        from collections import Counter

        countAB = Counter(a + b for a in A for b in B)
        return sum(countAB[-(c + d)] for c in C for d in D)