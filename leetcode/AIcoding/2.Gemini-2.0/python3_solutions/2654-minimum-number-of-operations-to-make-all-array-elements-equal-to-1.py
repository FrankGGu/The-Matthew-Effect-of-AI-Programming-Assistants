import math

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        n = len(nums)
        ones = nums.count(1)
        if ones > 0:
            return n - ones

        min_op = float('inf')
        for i in range(n):
            gcd_val = nums[i]
            for j in range(i + 1, n):
                gcd_val = math.gcd(gcd_val, nums[j])
                if gcd_val == 1:
                    min_op = min(min_op, j - i)
                    break

        if min_op == float('inf'):
            return -1
        else:
            return min_op + n - 1