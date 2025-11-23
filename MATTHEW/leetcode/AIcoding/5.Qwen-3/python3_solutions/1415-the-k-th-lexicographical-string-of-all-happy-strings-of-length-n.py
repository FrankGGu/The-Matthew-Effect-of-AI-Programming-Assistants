class Solution:
    def getHappyString(self, n: int, k: int) -> str:
        result = []

        def backtrack(path):
            if len(path) == n:
                result.append(''.join(path))
                return
            for c in ['a', 'b', 'c']:
                if not path or path[-1] != c:
                    path.append(c)
                    backtrack(path)
                    path.pop()
                    if len(result) >= k:
                        return

        backtrack([])
        return result[k-1] if k <= len(result) else ""