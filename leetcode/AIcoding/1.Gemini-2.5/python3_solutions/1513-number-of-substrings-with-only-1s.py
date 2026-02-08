class Solution:
    def numSub(self, s: str) -> int:
        MOD = 10**9 + 7
        total_substrings = 0
        current_ones_count = 0

        for char in s:
            if char == '1':
                current_ones_count += 1
            else:
                # If a '0' is encountered, calculate substrings for the previous block of '1's
                # The number of substrings for k consecutive '1's is k * (k + 1) / 2
                total_substrings = (total_substrings + (current_ones_count * (current_ones_count + 1) // 2)) % MOD
                current_ones_count = 0

        # After the loop, process any remaining consecutive '1's at the end of the string
        total_substrings = (total_substrings + (current_ones_count * (current_ones_count + 1) // 2)) % MOD

        return total_substrings