from bisect import bisect_right
from fractions import Fraction

class Solution:
    def kthSmallestPrimeFraction(self, arr: List[int], k: int) -> List[int]:
        left, right = 0.0, 1.0
        while left < right:
            mid = (left + right) / 2
            count = 0
            max_fraction = 0
            j = 0
            for i in range(len(arr)):
                while j < len(arr) and arr[i] / arr[j] < mid:
                    j += 1
                count += j
                if j > 0:
                    max_fraction = max(max_fraction, Fraction(arr[i], arr[j - 1]))
            if count > k:
                right = mid
            else:
                left = mid
        return [max_fraction.numerator, max_fraction.denominator]