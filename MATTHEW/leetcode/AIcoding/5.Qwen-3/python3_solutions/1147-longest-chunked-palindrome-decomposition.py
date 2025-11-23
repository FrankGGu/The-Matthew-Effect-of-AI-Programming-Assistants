class Solution:
    def longestDecomposition(self, s: str) -> int:
        def helper(s):
            n = len(s)
            for i in range(1, n // 2 + 1):
                if s[:i] == s[-i:]:
                    return 1 + helper(s[i:-i])
            return 0
        return helper(s)