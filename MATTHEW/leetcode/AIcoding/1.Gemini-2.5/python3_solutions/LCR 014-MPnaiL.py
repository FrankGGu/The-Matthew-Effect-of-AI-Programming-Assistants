class Solution:
    def permutation(self, s: str) -> list[str]:
        results = []
        n = len(s)
        char_array = sorted(list(s))
        used = [False] * n

        def backtrack(path):
            if len(path) == n:
                results.append("".join(path))
                return

            for i in range(n):
                if used[i]:
                    continue

                if i > 0 and char_array[i] == char_array[i-1] and not used[i-1]:
                    continue

                used[i] = True
                path.append(char_array[i])
                backtrack(path)
                path.pop()
                used[i] = False

        backtrack([])
        return results