class Solution:
    def permute(self, nums: List[int]) -> List[List[int]]:
        result = []
        def backtrack(combination, remaining):
            if not remaining:
                result.append(combination.copy())
                return

            for i in range(len(remaining)):
                combination.append(remaining[i])
                backtrack(combination, remaining[:i] + remaining[i+1:])
                combination.pop()

        backtrack([], nums)
        return result