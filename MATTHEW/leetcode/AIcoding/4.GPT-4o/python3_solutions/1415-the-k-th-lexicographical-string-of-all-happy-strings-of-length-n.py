class Solution:
    def getHappyString(self, n: int, k: int) -> str:
        def backtrack(path):
            if len(path) == n:
                happy_strings.append(''.join(path))
                return
            for char in 'abc':
                if not path or path[-1] != char:
                    backtrack(path + [char])

        happy_strings = []
        backtrack([])
        return happy_strings[k - 1] if k <= len(happy_strings) else ""