class Solution:
    def countPalindromes(self, s: str) -> int:
        from collections import defaultdict

        n = len(s)
        res = 0
        for i in range(1, n - 1):
            cnt = [0] * 26
            for j in range(i - 1, -1, -1):
                cnt[ord(s[j]) - ord('a')] += 1
            temp = [0] * 26
            for j in range(i + 1, n):
                temp[ord(s[j]) - ord('a')] += 1
            for k in range(26):
                if cnt[k] > 0 and temp[k] > 0:
                    res += cnt[k] * temp[k]
        return res