class Solution:
    def minimumBeautifulSubstrings(self, s: str) -> int:
        n = len(s)

        # Precompute powers of 5 in binary representation.
        # The maximum length of 's' is 15.
        # Powers of 5 and their binary representations up to length 15:
        # 5^0 = 1 (decimal) -> "1" (binary)
        # 5^1 = 5 (decimal) -> "101" (binary)
        # 5^2 = 25 (decimal) -> "11001" (binary)
        # 5^3 = 125 (decimal) -> "1111101" (binary)
        # 5^4 = 625 (decimal) -> "1001110001" (binary)
        # 5^5 = 3125 (decimal) -> "110000110101" (binary)
        # 5^6 = 15625 (decimal) -> "11110100001001" (binary)
        # 5^7 = 78125 (decimal) -> "1001100010110001" (binary) - Length 17, too long for s.

        beautiful_substrings = {
            "1",
            "101",
            "11001",
            "1111101",
            "1001110001",
            "110000110101",
            "11110100001001"
        }

        # dp[i] will store the minimum number of beautiful substrings to partition s[i:]
        # Initialize with infinity, dp[n] = 0 for the empty suffix (base case)
        dp = [float('inf')] * (n + 1)
        dp[n] = 0

        # Iterate from the end of the string backwards
        for i in range(n - 1, -1, -1):
            # A beautiful substring (power of 5) cannot start with '0'.
            # The only exception would be "0" itself, but 0 is not a power of 5.
            if s[i] == '0':
                continue

            # Try all possible substrings starting at index 'i'
            for j in range(i, n):
                sub = s[i : j + 1]

                if sub in beautiful_substrings:
                    # If s[i...j] is a beautiful substring, we can potentially form a partition.
                    # The number of partitions would be 1 (for this substring)
                    # plus the minimum partitions for the rest of the string s[j+1:].
                    # We only consider this option if s[j+1:] can also be partitioned.
                    if dp[j + 1] != float('inf'):
                        dp[i] = min(dp[i], 1 + dp[j + 1])

        # If dp[0] is still infinity, it means no valid partition was found for the entire string 's'.
        if dp[0] == float('inf'):
            return -1
        else:
            return dp[0]