class Solution:
    def longestIdealString(self, s: str, k: int) -> int:
        dp = [0] * 26

        for char_s in s:
            curr_char_code = ord(char_s) - ord('a')

            current_max_len = 0

            # Iterate through possible previous characters
            # The character codes for previous characters must be within [curr_char_code - k, curr_char_code + k]
            # And also within the valid range [0, 25]

            start_range = max(0, curr_char_code - k)
            end_range = min(25, curr_char_code + k)

            for prev_char_code in range(start_range, end_range + 1):
                current_max_len = max(current_max_len, dp[prev_char_code])

            dp[curr_char_code] = current_max_len + 1

        return max(dp)