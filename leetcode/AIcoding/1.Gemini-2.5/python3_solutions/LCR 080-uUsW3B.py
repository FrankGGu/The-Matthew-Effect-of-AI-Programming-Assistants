from typing import List

class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        results = []
        current_combination = []

        def backtrack(start_num):
            if len(current_combination) == k:
                results.append(list(current_combination))
                return

            # Optimization: Pruning
            # The loop for 'i' should not go beyond the point where it's impossible
            # to pick 'k - len(current_combination)' more elements from 'i' to 'n'.
            # The maximum value 'i' can take is 'n - (k - len(current_combination)) + 1'.
            # So, the range for 'i' should be from 'start_num' up to this maximum value (inclusive).
            # In Python's range, the end is exclusive, so we add 1.
            for i in range(start_num, n - (k - len(current_combination)) + 2):
                current_combination.append(i)
                backtrack(i + 1)
                current_combination.pop()

        backtrack(1)
        return results