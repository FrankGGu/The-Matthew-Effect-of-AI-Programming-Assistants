class Solution:
    def canWin(self, s: str) -> bool:
        return self.dfs(s, {})

    def dfs(self, s: str, memo: dict) -> bool:
        if s in memo:
            return memo[s]
        for i in range(len(s) - 1):
            if s[i:i + 2] == '++':
                next_s = s[:i] + '--' + s[i + 2:]
                if not self.dfs(next_s, memo):
                    memo[s] = True
                    return True
        memo[s] = False
        return False