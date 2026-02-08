class Solution:
    def numberOfWays(self, s: str) -> int:
        n = len(s)
        zeros_before = [0] * n
        ones_before = [0] * n
        zeros_after = [0] * n
        ones_after = [0] * n

        zeros_before[0] = 1 if s[0] == '0' else 0
        ones_before[0] = 1 if s[0] == '1' else 0

        for i in range(1, n):
            zeros_before[i] = zeros_before[i - 1] + (1 if s[i] == '0' else 0)
            ones_before[i] = ones_before[i - 1] + (1 if s[i] == '1' else 0)

        zeros_after[n - 1] = 1 if s[n - 1] == '0' else 0
        ones_after[n - 1] = 1 if s[n - 1] == '1' else 0

        for i in range(n - 2, -1, -1):
            zeros_after[i] = zeros_after[i + 1] + (1 if s[i] == '0' else 0)
            ones_after[i] = ones_after[i + 1] + (1 if s[i] == '1' else 0)

        ans = 0
        for i in range(1, n - 1):
            if s[i] == '0':
                ans += ones_before[i - 1] * ones_after[i + 1]
            else:
                ans += zeros_before[i - 1] * zeros_after[i + 1]

        return ans