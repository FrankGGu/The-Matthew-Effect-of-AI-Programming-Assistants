class Solution:
    def canReach(self, s: str, minJump: int, maxJump: int) -> bool:
        n = len(s)
        if s[0] == '1' or s[-1] == '1':
            return False

        reachable = 0
        for i in range(n):
            if i > reachable:
                return False
            if s[i] == '0':
                if i + minJump <= n:
                    reachable = max(reachable, i + maxJump)
            if reachable >= n - 1:
                return True
        return False