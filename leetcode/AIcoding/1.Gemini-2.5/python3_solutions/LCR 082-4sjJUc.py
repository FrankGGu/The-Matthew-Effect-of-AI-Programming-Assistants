class Solution:
    def combinationSum2(self, candidates: list[int], target: int) -> list[list[int]]:
        results = []
        candidates.sort()

        def backtrack(combination, remaining, start_index):
            if remaining == 0:
                results.append(list(combination))
                return
            if remaining < 0:
                return

            for i in range(start_index, len(candidates)):
                # Skip duplicates:
                # If the current element is the same as the previous element,
                # and it's not the first element considered at this level of recursion
                # (i.e., i > start_index), then skip it to avoid duplicate combinations.
                if i > start_index and candidates[i] == candidates[i-1]:
                    continue

                # Pruning: If the current candidate is greater than the remaining target,
                # then all subsequent candidates will also be greater (because candidates is sorted),
                # so we can break this loop.
                if candidates[i] > remaining:
                    break

                combination.append(candidates[i])
                # Each number can only be used once in the combination,
                # so we pass i + 1 for the next recursive call.
                backtrack(combination, remaining - candidates[i], i + 1)
                combination.pop() # Backtrack

        backtrack([], target, 0)
        return results