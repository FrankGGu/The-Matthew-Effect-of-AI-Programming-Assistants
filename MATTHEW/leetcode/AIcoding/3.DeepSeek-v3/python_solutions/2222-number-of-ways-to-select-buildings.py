class Solution:
    def numberOfWays(self, s: str) -> int:
        n = len(s)
        prefix = [[0] * 2 for _ in range(n + 1)]
        for i in range(n):
            prefix[i + 1][0] = prefix[i][0] + (1 if s[i] == '0' else 0)
            prefix[i + 1][1] = prefix[i][1] + (1 if s[i] == '1' else 0)

        res = 0
        for i in range(n):
            if s[i] == '0':
                left_1 = prefix[i][1]
                right_1 = prefix[n][1] - prefix[i + 1][1]
                res += left_1 * right_1
            else:
                left_0 = prefix[i][0]
                right_0 = prefix[n][0] - prefix[i + 1][0]
                res += left_0 * right_0
        return res