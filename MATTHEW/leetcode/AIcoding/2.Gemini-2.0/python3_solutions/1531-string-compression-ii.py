class Solution:
    def getLengthOfOptimalCompression(self, s: str, k: int) -> int:
        n = len(s)
        dp = {}

        def solve(i, k, last_char, last_count):
            if (i, k, last_char, last_count) in dp:
                return dp[(i, k, last_char, last_count)]

            if i == n:
                return 0

            if k < 0:
                return float('inf')

            if s[i] == last_char:
                increment = 1 if last_count in [1, 9, 99] else 0
                res = increment + solve(i + 1, k, last_char, last_count + 1)
            else:
                keep_new = 1 + solve(i + 1, k, s[i], 1)
                discard = solve(i + 1, k - 1, last_char, last_count)
                res = min(keep_new, discard)

            dp[(i, k, last_char, last_count)] = res
            return res

        return solve(0, k, '', 0)