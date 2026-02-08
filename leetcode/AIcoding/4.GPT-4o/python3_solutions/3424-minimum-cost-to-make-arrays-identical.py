class Solution:
    def minCost(self, A: List[int], B: List[int]) -> int:
        from collections import Counter
        countA = Counter(A)
        countB = Counter(B)

        total_cost = 0
        for num in countA:
            if num in countB:
                total_cost += abs(countA[num] - countB[num]) * abs(num)
            else:
                total_cost += countA[num] * abs(num)

        for num in countB:
            if num not in countA:
                total_cost += countB[num] * abs(num)

        return total_cost