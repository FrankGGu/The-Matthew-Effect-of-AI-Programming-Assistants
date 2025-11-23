class Solution:
    def countHomogenous(self, s: str) -> int:
        MOD = 10**9 + 7
        total_count = 0
        current_length = 0

        for i in range(len(s)):
            if i == 0 or s[i] == s[i-1]:
                current_length += 1
            else:
                # Current character is different from the previous one.
                # Calculate contributions for the previous homogenous block.
                # A block of length `n` contributes n * (n + 1) / 2 substrings.
                total_count = (total_count + current_length * (current_length + 1) // 2) % MOD
                # Start a new homogenous block with length 1.
                current_length = 1

        # After the loop, add the contribution for the last homogenous block.
        total_count = (total_count + current_length * (current_length + 1) // 2) % MOD

        return total_count