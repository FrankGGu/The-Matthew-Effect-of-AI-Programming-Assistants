class Solution:
    def findGoodStrings(self, n: int, s1: str, s2: str, evil: str) -> int:
        MOD = 10**9 + 7
        m = len(evil)

        def compute_lps(pattern):
            lps = [0] * m
            length = 0
            i = 1
            while i < m:
                if pattern[i] == pattern[length]:
                    length += 1
                    lps[i] = length
                    i += 1
                else:
                    if length != 0:
                        length = lps[length - 1]
                    else:
                        lps[i] = 0
                        i += 1
            return lps

        lps = compute_lps(evil)

        dp = {}

        def solve(index, evil_index, tight1, tight2):
            if evil_index == m:
                return 0
            if index == n:
                return 1

            key = (index, evil_index, tight1, tight2)
            if key in dp:
                return dp[key]

            start = s1[index] if tight1 else 'a'
            end = s2[index] if tight2 else 'z'

            count = 0
            for char in range(ord(start), ord(end) + 1):
                curr_char = chr(char)
                new_evil_index = evil_index
                while new_evil_index > 0 and curr_char != evil[new_evil_index]:
                    new_evil_index = lps[new_evil_index - 1]
                if curr_char == evil[new_evil_index]:
                    new_evil_index += 1

                new_tight1 = tight1 and curr_char == s1[index]
                new_tight2 = tight2 and curr_char == s2[index]

                count = (count + solve(index + 1, new_evil_index, new_tight1, new_tight2)) % MOD

            dp[key] = count
            return count

        return solve(0, 0, True, True)