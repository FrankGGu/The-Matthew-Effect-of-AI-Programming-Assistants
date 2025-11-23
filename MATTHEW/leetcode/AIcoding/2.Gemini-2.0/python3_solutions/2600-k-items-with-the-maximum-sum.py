class Solution:
    def kItemsWithMaximumSum(self, numOnes: int, numZeros: int, numNegOnes: int, k: int) -> int:
        ans = 0
        if k <= numOnes:
            ans = k
        else:
            ans += numOnes
            k -= numOnes
            if k <= numZeros:
                ans += 0
            else:
                k -= numZeros
                ans -= k
        return ans