class Solution:
    def minOperations(self, A: List[int], B: List[int]) -> int:
        from collections import Counter

        countA = Counter(A)
        countB = Counter(B)

        total_operations = 0

        for key in set(countA.keys()).union(countB.keys()):
            total_operations += abs(countA[key] - countB[key])

        return total_operations // 2