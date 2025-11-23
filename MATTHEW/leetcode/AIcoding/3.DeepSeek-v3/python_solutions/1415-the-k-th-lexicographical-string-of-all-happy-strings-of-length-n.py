class Solution:
    def getHappyString(self, n: int, k: int) -> str:
        happy_strings = []
        chars = ['a', 'b', 'c']

        def backtrack(current):
            if len(current) == n:
                happy_strings.append(current)
                return
            for c in chars:
                if not current or c != current[-1]:
                    backtrack(current + c)

        backtrack("")
        if k > len(happy_strings):
            return ""
        return happy_strings[k-1]