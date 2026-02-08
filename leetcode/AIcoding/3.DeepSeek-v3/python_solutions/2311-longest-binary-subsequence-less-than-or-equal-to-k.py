class Solution:
    def longestSubsequence(self, s: str, k: int) -> int:
        n = len(s)
        res = 0
        val = 0
        for i in range(n - 1, -1, -1):
            if s[i] == '0':
                res += 1
            else:
                if res < 30 and (val | (1 << res)) <= k:
                    val |= 1 << res
                    res += 1
        return res