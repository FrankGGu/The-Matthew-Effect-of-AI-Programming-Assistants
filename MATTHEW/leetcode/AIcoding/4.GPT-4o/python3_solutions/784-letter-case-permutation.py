class Solution:
    def letterCasePermutation(self, s: str) -> List[str]:
        res = []
        def backtrack(sub="", index=0):
            if index == len(s):
                res.append(sub)
                return
            backtrack(sub + s[index], index + 1)
            if s[index].isalpha():
                backtrack(sub + (s[index].swapcase()), index + 1)
        backtrack()
        return res