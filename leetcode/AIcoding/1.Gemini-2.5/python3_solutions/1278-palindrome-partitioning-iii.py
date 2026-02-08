import math

class Solution:
    def palindromePartitionIII(self, s: str, k: int) -> int:
        n = len(s)

        # Step 1: Precompute the cost to make any substring s[i...j] a palindrome
        # cost[i][j] stores the minimum changes to make s[i...j] a palindrome
        # Indices i and j are 0-based.
        cost = [[0] * n for _ in range(n)]

        # Calculate costs for substrings of length 2 up to n
        for length in range(2, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                # The cost for s[i...j] is inherited from the inner substring s[i+1...j-1]
                # If length is 2, s[i+1...j-1] is an empty string, which has 0 cost.
                # Our initialization of `cost` to all zeros handles this case correctly
                # as cost[i+1][i] (when j-1 = i) would be 0.
                cost[i][j] = cost[i+1][j-1]
                # Add 1 if the outer characters don't match
                if s[i] != s[j]:
                    cost[i][j] += 1

        # Step 2: Dynamic Programming
        # dp[i][j] = minimum changes to partition s[0...i-1] into j palindromic substrings
        # i ranges from 0 to n (length of prefix)
        # j ranges from 0 to k (number of partitions)
        dp = [[math.inf] * (k + 1) for _ in range(n + 1)]

        # Base case: 0 characters, 0 partitions, 0 cost
        dp[0][0] = 0

        # Iterate over the number of partitions (j) from 1 to k
        for j in range(1, k + 1):
            # Iterate over the length of the prefix (i) from 1 to n
            for i in range(1, n + 1):
                # If the number of characters (i) is less than the number of partitions (j),
                # it's impossible to partition, so skip.
                if i < j:
                    continue

                # Iterate over possible split points (p) for the j-th partition
                # s[0...p-1] forms j-1 partitions
                # s[p...i-1] forms the j-th partition
                # 'p' is the end index of the previous (j-1)-th partition's prefix.
                # So, s[0...p-1] is the prefix of length 'p'.
                # 'p' must be at least j-1, because s[0...p-1] must be partitioned into j-1 parts.
                # 'p' must be less than 'i', because s[p...i-1] must be a non-empty substring.
                for p in range(j - 1, i):
                    # If dp[p][j-1] is not infinity, it means s[0...p-1] can be partitioned into j-1 parts
                    if dp[p][j-1] != math.inf:
                        # The cost for the current (j-th) partition s[p...i-1]
                        current_partition_cost = cost[p][i-1]
                        # Update dp[i][j] with the minimum cost
                        dp[i][j] = min(dp[i][j], dp[p][j-1] + current_partition_cost)

        return dp[n][k]