class Solution:
    def minChanges(self, s: str, k: int) -> int:
        n = len(s)

        # Step 1: Precompute palindrome_cost[i][j]
        # min changes to make s[i...j] a palindrome
        palindrome_cost = [[0] * n for _ in range(n)]

        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                cost = palindrome_cost[i + 1][j - 1] if i + 1 <= j - 1 else 0
                if s[i] != s[j]:
                    cost += 1
                palindrome_cost[i][j] = cost

        # Step 2: Precompute semi_palindrome_cost[i][j]
        # min changes to make s[i...j] a semi-palindrome
        # A semi-palindrome can be partitioned into two non-empty palindrome parts p1 and p2.
        # Minimum length for a semi-palindrome is 2.
        semi_palindrome_cost = [[float('inf')] * n for _ in range(n)]

        for i in range(n):
            for j in range(i, n):
                if j - i + 1 < 2:  # A semi-palindrome needs at least 2 characters
                    continue
                # Split s[i...j] into s[i...m] (p1) and s[m+1...j] (p2)
                # Both p1 and p2 must be non-empty.
                # So m ranges from i to j-1.
                for m in range(i, j):
                    cost_p1 = palindrome_cost[i][m]
                    cost_p2 = palindrome_cost[m + 1][j]
                    semi_palindrome_cost[i][j] = min(semi_palindrome_cost[i][j], cost_p1 + cost_p2)

        # Step 3: DP to find minimum total changes
        # dp[k_val][i] = min changes to partition s[0...i-1] into k_val semi-palindromes
        dp = [[float('inf')] * (n + 1) for _ in range(k + 1)]
        dp[0][0] = 0

        for k_val in range(1, k + 1):
            # i represents the current prefix length (s[0...i-1])
            # Minimum length for k_val semi-palindromes is 2 * k_val
            for i in range(2 * k_val, n + 1):
                # j represents the start index of the last semi-palindrome s[j...i-1]
                # The prefix s[0...j-1] must be partitioned into k_val-1 semi-palindromes.
                # Its length 'j' must be at least 2 * (k_val-1).
                # The last semi-palindrome s[j...i-1] must have a length of at least 2.
                # So, (i-1) - j + 1 >= 2  =>  i - j >= 2  =>  j <= i - 2.
                for j in range(2 * (k_val - 1), i - 1): # j goes from 2*(k_val-1) up to i-2
                    if dp[k_val - 1][j] != float('inf'):
                        cost_last_semi = semi_palindrome_cost[j][i - 1]
                        dp[k_val][i] = min(dp[k_val][i], dp[k_val - 1][j] + cost_last_semi)

        return dp[k][n]