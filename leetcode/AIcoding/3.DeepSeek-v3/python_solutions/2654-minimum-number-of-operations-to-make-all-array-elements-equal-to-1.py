import math

class Solution:
    def minOperations(self, nums: List[int]) -> int:
        n = len(nums)
        if 1 in nums:
            return n - nums.count(1)

        min_operations = float('inf')

        for i in range(n):
            current_gcd = nums[i]
            for j in range(i, n):
                current_gcd = math.gcd(current_gcd, nums[j])
                if current_gcd == 1:
                    operations = (j - i) + (n - 1)
                    if operations < min_operations:
                        min_operations = operations
                    break

        return min_operations if min_operations != float('inf') else -1