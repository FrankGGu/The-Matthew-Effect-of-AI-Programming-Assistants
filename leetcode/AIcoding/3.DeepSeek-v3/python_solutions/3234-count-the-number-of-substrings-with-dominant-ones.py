class Solution:
    def countSubstrings(self, s: str) -> int:
        res = 0
        n = len(s)
        for i in range(n):
            count_1 = 0
            for j in range(i, n):
                if s[j] == '1':
                    count_1 += 1
                total = j - i + 1
                if count_1 > total / 2:
                    res += 1
        return res