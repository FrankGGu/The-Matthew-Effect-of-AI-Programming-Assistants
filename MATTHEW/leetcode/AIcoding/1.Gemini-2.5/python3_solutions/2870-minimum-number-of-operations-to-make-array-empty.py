import collections
import math

class Solution:
    def minOperations(self, nums: list[int]) -> int:
        counts = collections.Counter(nums)

        total_operations = 0
        for count in counts.values():
            if count == 1:
                return -1

            total_operations += math.ceil(count / 3)

        return total_operations