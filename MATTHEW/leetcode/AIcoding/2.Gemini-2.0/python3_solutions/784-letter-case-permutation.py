class Solution:
    def letterCasePermutation(self, s: str) -> list[str]:
        res = []
        def backtrack(index, current):
            if index == len(s):
                res.append("".join(current))
                return

            char = s[index]
            if char.isalpha():
                backtrack(index + 1, current + [char.lower()])
                backtrack(index + 1, current + [char.upper()])
            else:
                backtrack(index + 1, current + [char])

        backtrack(0, [])
        return res