class Solution:
    def distinctSubseqII(self, s: str) -> int:
        MOD = 10**9 + 7

        last_char_counts = [0] * 26
        total_distinct = 0

        for char_code in map(ord, s):
            idx = char_code - ord('a')

            count_ending_with_current_char = (1 + total_distinct) % MOD

            total_distinct = (total_distinct + count_ending_with_current_char - last_char_counts[idx] + MOD) % MOD

            last_char_counts[idx] = count_ending_with_current_char

        return total_distinct