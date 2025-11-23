class Solution:
    def maximumSum(self, numOnes: int, numZeros: int, numNegOnes: int, k: int) -> int:
        current_sum = 0

        # Take items with value 1
        take_ones = min(k, numOnes)
        current_sum += take_ones * 1
        k -= take_ones

        if k == 0:
            return current_sum

        # Take items with value 0
        take_zeros = min(k, numZeros)
        # current_sum += take_zeros * 0 # This doesn't change the sum
        k -= take_zeros

        if k == 0:
            return current_sum

        # Take items with value -1
        take_neg_ones = min(k, numNegOnes)
        current_sum += take_neg_ones * -1
        k -= take_neg_ones

        return current_sum