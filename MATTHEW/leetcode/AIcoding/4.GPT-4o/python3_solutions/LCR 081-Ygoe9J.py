class Solution:
    def combinationSum(self, candidates: List[int], target: int) -> List[List[int]]:
        res = []

        def backtrack(remaining, combo, start):
            if remaining == 0:
                res.append(list(combo))
                return
            elif remaining < 0:
                return

            for i in range(start, len(candidates)):
                combo.append(candidates[i])
                backtrack(remaining - candidates[i], combo, i)
                combo.pop()

        backtrack(target, [], 0)
        return res