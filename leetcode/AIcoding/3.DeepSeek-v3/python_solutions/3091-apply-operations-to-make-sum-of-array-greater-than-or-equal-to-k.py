import math

class Solution:
    def minOperations(self, k: int) -> int:
        if k == 1:
            return 0
        min_operations = float('inf')
        max_a = math.ceil(math.sqrt(k)) + 1
        for a in range(1, max_a + 1):
            b = math.ceil(k / a) - 1
            operations = (a - 1) + b
            if operations < min_operations:
                min_operations = operations
        return min_operations