class Solution:
    def kItemsWithMaximumSum(self, numOnes: int, numZeros: int, numNegOnes: int, k: int) -> int:
        res = 0
        take = min(numOnes, k)
        res += take
        k -= take
        if k == 0:
            return res
        take = min(numZeros, k)
        k -= take
        if k == 0:
            return res
        take = min(numNegOnes, k)
        res -= take
        return res