import collections
import math

class Solution:
    def countBeautifulSubstrings(self, s: str, k: int) -> int:
        n = len(s)
        vowels = {'a', 'e', 'i', 'o', 'u'}

        L = 1
        temp_k = k
        d = 2
        while d * d <= temp_k:
            if temp_k % d == 0:
                count = 0
                while temp_k % d == 0:
                    count += 1
                    temp_k //= d
                L *= d ** ((count + 1) // 2)
            d += 1
        if temp_k > 1:
            L *= temp_k 

        ans = 0
        v_count = 0

        memo = collections.defaultdict(lambda: collections.defaultdict(int))

        memo[0][0] = 1

        for j in range(n):
            char = s[j]
            if char in vowels:
                v_count += 1

            current_idx = j + 1 

            curr_p_val = 2 * v_count - current_idx
            curr_rem_L = v_count % L

            ans += memo[curr_p_val][curr_rem_L]

            memo[curr_p_val][curr_rem_L] += 1

        return ans