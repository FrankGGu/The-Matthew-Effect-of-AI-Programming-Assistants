class Solution:
    def maxAbsValExpr(self, arr1: List[int], arr2: List[int]) -> int:
        n = len(arr1)
        max1 = max2 = max3 = max4 = -float('inf')
        min1 = min2 = min3 = min4 = float('inf')

        for i in range(n):
            val1 = arr1[i] + arr2[i] + i
            val2 = arr1[i] - arr2[i] + i
            val3 = -arr1[i] + arr2[i] + i
            val4 = -arr1[i] - arr2[i] + i

            max1 = max(max1, val1)
            min1 = min(min1, val1)

            max2 = max(max2, val2)
            min2 = min(min2, val2)

            max3 = max(max3, val3)
            min3 = min(min3, val3)

            max4 = max(max4, val4)
            min4 = min(min4, val4)

        diff1 = max1 - min1
        diff2 = max2 - min2
        diff3 = max3 - min3
        diff4 = max4 - min4

        return max(diff1, diff2, diff3, diff4)