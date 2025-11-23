import collections
from functools import lru_cache

class Solution:
    def findGoodStrings(self, n: int, s1: str, s2: str, evil: str) -> int:
        MOD = 10**9 + 7
        m = len(evil)

        lps = [0] * m
        length = 0
        i = 1
        while i < m:
            if evil[i] == evil[length]:
                length += 1
                lps[i] = length
                i += 1
            else:
                if length != 0:
                    length = lps[length - 1]
                else:
                    lps[i] = 0
                    i += 1

        kmp_transitions = [[0] * 26 for _ in range(m)]

        for j in range(m):
            for char_code in range(26):
                char_val = chr(ord('a') + char_code)

                temp_state = j
                while temp_state > 0 and evil[temp_state] != char_val:
                    temp_state = lps[temp_state - 1]

                if evil[temp_state] == char_val:
                    kmp_transitions[j][char_code] = temp_state + 1
                else:
                    kmp_transitions[j][char_code] = 0

        @lru_cache(None)
        def dp(idx, evil_match_len, tight_s1, tight_s2):
            if evil_match_len == m:
                return 0
            if idx == n:
                return 1

            ans = 0

            lower_bound_char_ord = ord(s1[idx]) if tight_s1 else ord('a')
            upper_bound_char_ord = ord(s2[idx]) if tight_s2 else ord('z')

            for char_code in range(26):
                current_char_ord = ord('a') + char_code

                if not (lower_bound_char_ord <= current_char_ord <= upper_bound_char_ord):
                    continue

                new_tight_s1 = tight_s1 and (current_char_ord == ord(s1[idx]))
                new_tight_s2 = tight_s2 and (current_char_ord == ord(s2[idx]))

                next_evil_match_len = kmp_transitions[evil_match_len][char_code]

                ans = (ans + dp(idx + 1, next_evil_match_len, new_tight_s1, new_tight_s2)) % MOD

            return ans

        return dp(0, 0, True, True)