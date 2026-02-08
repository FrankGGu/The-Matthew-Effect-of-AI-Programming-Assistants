class Solution:
    def permute(self, nums: list[int]) -> list[list[int]]:
        result = []
        n = len(nums)
        visited = [False] * n
        current_permutation = []

        def backtrack():
            if len(current_permutation) == n:
                result.append(list(current_permutation))
                return

            for i in range(n):
                if not visited[i]:
                    visited[i] = True
                    current_permutation.append(nums[i])
                    backtrack()
                    current_permutation.pop()
                    visited[i] = False

        backtrack()
        return result