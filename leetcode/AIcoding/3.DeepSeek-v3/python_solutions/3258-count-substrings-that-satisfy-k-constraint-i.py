class Solution:
    def countSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        res = 0
        for i in range(n):
            freq = [0] * 26
            distinct = 0
            for j in range(i, n):
                idx = ord(s[j]) - ord('a')
                if freq[idx] == 0:
                    distinct += 1
                freq[idx] += 1
                if distinct >= k:
                    res += 1
        return res