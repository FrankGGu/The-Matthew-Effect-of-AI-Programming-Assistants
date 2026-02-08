class Solution:
    def minOperations(self, A: List[int], B: List[int]) -> int:
        A.sort()
        B.sort()
        n = len(A)
        countA = Counter()
        countB = Counter()

        for a in A:
            countA[a] += 1
        for b in B:
            countB[b] += 1

        diff = 0
        for key in set(countA.keys()).union(countB.keys()):
            diff += abs(countA[key] - countB[key])

        return diff // 2