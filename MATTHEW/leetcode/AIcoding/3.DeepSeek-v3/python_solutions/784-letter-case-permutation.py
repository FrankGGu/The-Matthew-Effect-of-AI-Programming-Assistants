class Solution:
    def letterCasePermutation(self, s: str) -> List[str]:
        res = []
        self.dfs(s, 0, [], res)
        return res

    def dfs(self, s, index, path, res):
        if index == len(s):
            res.append(''.join(path))
            return
        char = s[index]
        if char.isalpha():
            self.dfs(s, index + 1, path + [char.lower()], res)
            self.dfs(s, index + 1, path + [char.upper()], res)
        else:
            self.dfs(s, index + 1, path + [char], res)