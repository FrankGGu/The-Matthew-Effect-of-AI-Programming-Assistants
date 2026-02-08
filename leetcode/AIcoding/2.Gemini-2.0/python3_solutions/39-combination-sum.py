class Solution:
    def combinationSum(self, candidates: list[int], target: int) -> list[list[int]]:
        result = []

        def backtrack(combination, remaining, start):
            if remaining == 0:
                result.append(combination.copy())
                return
            if remaining < 0:
                return

            for i in range(start, len(candidates)):
                combination.append(candidates[i])
                backtrack(combination, remaining - candidates[i], i)
                combination.pop()

        backtrack([], target, 0)
        return result