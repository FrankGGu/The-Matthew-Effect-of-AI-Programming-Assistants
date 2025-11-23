class Solution:
    def combine(self, n: int, k: int) -> list[list[int]]:
        results = []
        current_combination = []

        def backtrack(start_num):
            if len(current_combination) == k:
                results.append(list(current_combination))
                return

            # Optimization: Pruning
            # The number of elements needed is k - len(current_combination)
            # The maximum value for 'i' we can pick is n - (elements_needed - 1)
            # which is n - k + len(current_combination) + 1
            # So, the loop for 'i' should go up to this value.
            # Python's range is exclusive at the end, so we add 1 to the upper bound.
            upper_limit_for_i = n - (k - len(current_combination)) + 1

            for i in range(start_num, upper_limit_for_i + 1):
                current_combination.append(i)
                backtrack(i + 1)
                current_combination.pop()

        backtrack(1)
        return results