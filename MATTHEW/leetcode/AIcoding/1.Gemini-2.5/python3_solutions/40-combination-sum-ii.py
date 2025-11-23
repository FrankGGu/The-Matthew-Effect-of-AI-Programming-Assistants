class Solution:
    def combinationSum2(self, candidates: list[int], target: int) -> list[list[int]]:
        result = []
        candidates.sort()

        def backtrack(current_combination, remaining_target, start_index):
            if remaining_target == 0:
                result.append(list(current_combination))
                return
            if remaining_target < 0:
                return

            for i in range(start_index, len(candidates)):
                # Skip duplicates
                if i > start_index and candidates[i] == candidates[i-1]:
                    continue

                candidate = candidates[i]
                current_combination.append(candidate)
                backtrack(current_combination, remaining_target - candidate, i + 1)
                current_combination.pop()

        backtrack([], target, 0)
        return result