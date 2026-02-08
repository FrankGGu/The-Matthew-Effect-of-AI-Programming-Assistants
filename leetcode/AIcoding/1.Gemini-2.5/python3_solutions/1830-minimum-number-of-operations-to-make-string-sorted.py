class Solution:
    def makeStringSorted(self, s: str) -> int:
        MOD = 10**9 + 7
        n = len(s)

        fact = [1] * (n + 1)
        inv_fact = [1] * (n + 1)
        for i in range(1, n + 1):
            fact[i] = (fact[i-1] * i) % MOD

        inv_fact[n] = pow(fact[n], MOD - 2, MOD)
        for i in range(n - 1, -1, -1):
            inv_fact[i] = (inv_fact[i+1] * (i+1)) % MOD

        counts = [0] * 26
        for char_code in s:
            counts[ord(char_code) - ord('a')] += 1

        ans = 0
        for i in range(n):
            current_char_code_val = ord(s[i]) - ord('a')
            remaining_length = n - 1 - i

            num_smaller_chars = 0
            for char_code_idx in range(current_char_code_val):
                num_smaller_chars += counts[char_code_idx]

            if num_smaller_chars > 0:
                denominator = 1
                for char_code_idx in range(26):
                    denominator = (denominator * inv_fact[counts[char_code_idx]]) % MOD

                permutations_for_this_step = (fact[remaining_length] * denominator) % MOD
                permutations_for_this_step = (permutations_for_this_step * num_smaller_chars) % MOD

                ans = (ans + permutations_for_this_step) % MOD

            counts[current_char_code_val] -= 1

        return ans