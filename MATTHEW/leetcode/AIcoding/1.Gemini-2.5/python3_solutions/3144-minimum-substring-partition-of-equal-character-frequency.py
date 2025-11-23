import collections

class Solution:
    def minimumSubstringsInPartition(self, s: str) -> int:
        n = len(s)
        dp = [float('inf')] * (n + 1)
        dp[0] = 0

        for i in range(1, n + 1):
            counts = collections.defaultdict(int)
            for j in range(i - 1, -1, -1):
                char = s[j]
                counts[char] += 1

                is_valid = True
                first_freq = -1
                for count in counts.values():
                    if first_freq == -1:
                        first_freq = count
                    elif count != first_freq:
                        is_valid = False
                        break

                if is_valid:
                    dp[i] = min(dp[i], dp[j] + 1)

        return dp[n]