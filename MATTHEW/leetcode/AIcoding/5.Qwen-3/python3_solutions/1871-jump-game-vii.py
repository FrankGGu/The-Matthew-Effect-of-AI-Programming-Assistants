class Solution:
    def canReach(self, s: str, minJump: int, maxJump: int) -> bool:
        n = len(s)
        dp = [False] * n
        dp[0] = True
        farthest = 0
        for i in range(1, n):
            if i > farthest:
                return False
            if s[i] == '0':
                left = max(minJump, i - maxJump)
                right = i - minJump
                if left <= right and any(dp[j] for j in range(left, right + 1)):
                    dp[i] = True
                else:
                    dp[i] = False
            else:
                dp[i] = False
            farthest = max(farthest, i + maxJump)
        return dp[-1]