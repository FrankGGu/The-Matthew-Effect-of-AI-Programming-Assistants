class Solution:
    def findTheLongestBalancedSubstring(self, s: str) -> int:
        n = len(s)
        max_len = 0

        for i in range(n):
            if s[i] == '1':
                continue

            zeros = 0
            ones = 0
            for j in range(i, n):
                if s[j] == '0':
                    if ones > 0:
                        # Encountered a '0' after '1's,
                        # this substring is no longer in the "0...01...1" pattern.
                        break
                    zeros += 1
                else: # s[j] == '1'
                    ones += 1

                if zeros == ones and zeros > 0:
                    max_len = max(max_len, zeros * 2)

        return max_len