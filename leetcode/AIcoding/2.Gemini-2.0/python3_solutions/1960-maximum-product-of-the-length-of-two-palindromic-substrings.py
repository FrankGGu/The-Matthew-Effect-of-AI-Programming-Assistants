class Solution:
    def maxProduct(self, s: str) -> int:
        n = len(s)
        left_max = [0] * n
        right_max = [0] * n

        def longest_palindrome(s):
            n = len(s)
            dp = [[False] * n for _ in range(n)]
            max_len = 1
            start = 0
            for i in range(n):
                dp[i][i] = True
            for i in range(n - 1):
                if s[i] == s[i + 1]:
                    dp[i][i + 1] = True
                    start = i
                    max_len = 2
            for k in range(3, n + 1):
                for i in range(n - k + 1):
                    j = i + k - 1
                    if s[i] == s[j] and dp[i + 1][j - 1]:
                        dp[i][j] = True
                        if k > max_len:
                            start = i
                            max_len = k
            return max_len

        for i in range(n):
            left_max[i] = longest_palindrome(s[:i+1])
            if i > 0:
                left_max[i] = max(left_max[i], left_max[i-1])

        for i in range(n - 1, -1, -1):
            right_max[i] = longest_palindrome(s[i:])
            if i < n - 1:
                right_max[i] = max(right_max[i], right_max[i+1])

        max_product = 0
        for i in range(n - 1):
            max_product = max(max_product, left_max[i] * right_max[i+1])

        return max_product