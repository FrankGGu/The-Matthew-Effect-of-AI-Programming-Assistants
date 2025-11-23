class Solution:
    def isScramble(self, s1: str, s2: str) -> bool:
        n = len(s1)
        if n != len(s2):
            return False
        if s1 == s2:
            return True
        if sorted(s1) != sorted(s2):
            return False

        dp = {}

        def solve(s1, s2):
            if (s1, s2) in dp:
                return dp[(s1, s2)]

            if s1 == s2:
                dp[(s1, s2)] = True
                return True

            if sorted(s1) != sorted(s2):
                dp[(s1, s2)] = False
                return False

            n = len(s1)
            for i in range(1, n):
                if (solve(s1[:i], s2[:i]) and solve(s1[i:], s2[i:])) or \
                   (solve(s1[:i], s2[n-i:]) and solve(s1[i:], s2[:n-i])):
                    dp[(s1, s2)] = True
                    return True

            dp[(s1, s2)] = False
            return False

        return solve(s1, s2)