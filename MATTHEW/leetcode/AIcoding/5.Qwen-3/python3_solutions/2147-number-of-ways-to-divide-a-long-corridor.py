class Solution:
    def numberOfWays(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)
        left = [0] * n
        right = [0] * n
        count = 0
        for i in range(n):
            if s[i] == '1':
                count += 1
            left[i] = count
        count = 0
        for i in range(n - 1, -1, -1):
            if s[i] == '1':
                count += 1
            right[i] = count
        res = 0
        for i in range(1, n - 1):
            if s[i] == '0':
                res += left[i] * right[i]
                res %= MOD
        return res