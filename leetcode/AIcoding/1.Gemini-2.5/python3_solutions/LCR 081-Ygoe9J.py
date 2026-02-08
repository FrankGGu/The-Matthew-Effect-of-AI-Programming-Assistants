class Solution:
    def combinationSum(self, candidates: list[int], target: int) -> list[list[int]]:
        result = []
        candidates.sort()

        def backtrack(remain, current_combination, start_index):
            if remain == 0:
                result.append(list(current_combination))
                return
            if remain < 0:
                return

            for i in range(start_index, len(candidates)):
                if candidates[i] > remain:
                    break

                current_combination.append(candidates[i])
                backtrack(remain - candidates[i], current_combination, i)
                current_combination.pop()

        backtrack(target, [], 0)
        return result