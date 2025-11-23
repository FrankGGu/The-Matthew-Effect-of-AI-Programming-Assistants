from typing import List

class Solution:
    def missingRolls(self, rolls: List[int], n: int, mean: int) -> List[int]:
        m = len(rolls)

        target_total_sum = (m + n) * mean
        current_rolls_sum = sum(rolls)

        missing_sum = target_total_sum - current_rolls_sum

        min_possible_missing_sum = n * 1
        max_possible_missing_sum = n * 6

        if not (min_possible_missing_sum <= missing_sum <= max_possible_missing_sum):
            return []

        result = []
        base_val = missing_sum // n
        remainder = missing_sum % n

        for i in range(n):
            val = base_val
            if i < remainder:
                val += 1
            result.append(val)

        return result