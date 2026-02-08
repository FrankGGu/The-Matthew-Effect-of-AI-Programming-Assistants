class Solution:
    def combinationSum3(self, k: int, n: int) -> list[list[int]]:
        result = []
        current_combination = []

        def backtrack(start_num, current_sum):
            if current_sum == n and len(current_combination) == k:
                result.append(list(current_combination))
                return

            if current_sum > n or len(current_combination) > k:
                return

            for i in range(start_num, 10):
                current_combination.append(i)
                backtrack(i + 1, current_sum + i)
                current_combination.pop()

        backtrack(1, 0)
        return result