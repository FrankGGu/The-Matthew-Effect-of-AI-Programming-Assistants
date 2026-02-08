class Solution:
    def permute(self, nums: list[int]) -> list[list[int]]:
        result = []
        n = len(nums)
        current_permutation = []
        used = [False] * n

        def backtrack():
            if len(current_permutation) == n:
                result.append(list(current_permutation))
                return

            for i in range(n):
                if not used[i]:
                    current_permutation.append(nums[i])
                    used[i] = True
                    backtrack()
                    used[i] = False
                    current_permutation.pop()

        backtrack()
        return result