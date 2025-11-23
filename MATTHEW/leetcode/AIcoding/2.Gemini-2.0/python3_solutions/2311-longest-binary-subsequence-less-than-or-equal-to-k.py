class Solution:
    def longestSubsequence(self, s: str, k: int) -> int:
        count = 0
        val = 0
        power = 1
        for i in range(len(s) - 1, -1, -1):
            if s[i] == '0':
                count += 1
            else:
                if val + power <= k:
                    val += power
                    count += 1
                power *= 2
        return count