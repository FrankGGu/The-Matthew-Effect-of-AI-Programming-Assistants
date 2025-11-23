class Solution:
    def combine(self, n: int, k: int) -> List[List[int]]:
        def backtrack(start, path):
            if len(path) == k:
                result.append(path)
                return
            for i in range(start, n + 1):
                backtrack(i + 1, path + [i])

        result = []
        backtrack(1, [])
        return result