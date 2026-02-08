import math

class Solution:
    def minElements(self, nums: list[int], limit: int, goal: int) -> int:
        current_sum = sum(nums)

        diff = goal - current_sum

        abs_diff = abs(diff)

        # We need to cover abs_diff. Each added element can contribute at most 'limit'.
        # The number of elements needed is ceil(abs_diff / limit).
        # Using integer division: (a + b - 1) // b for ceil(a / b) where a, b > 0.
        # If abs_diff is 0, this correctly results in 0.

        return (abs_diff + limit - 1) // limit