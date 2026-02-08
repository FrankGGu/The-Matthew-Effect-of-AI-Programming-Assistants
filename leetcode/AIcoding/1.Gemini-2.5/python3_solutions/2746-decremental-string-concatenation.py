import math

class Solution:
    def minimizeConcatenatedLength(self, words: list[str]) -> int:
        n = len(words)

        # dp[last_char_code] stores the minimum total length
        # when the current concatenated string ends with 'a' + last_char_code.
        # last_char_code is an integer from 0 to 25.
        dp = [math.inf] * 26

        # Base case: first word
        first_word = words[0]
        first_word_len = len(first_word)
        first_word_end_char_code = ord(first_word[-1]) - ord('a')
        dp[first_word_end_char_code] = first_word_len

        # Iterate through the rest of the words
        for i in range(1, n):
            current_word = words[i]
            current_word_len = len(current_word)
            current_word_start_char_code = ord(current_word[0]) - ord('a')
            current_word_end_char_code = ord(current_word[-1]) - ord('a')

            next_dp = [math.inf] * 26

            # Iterate through all possible ending characters of the previous concatenation
            for prev_end_char_code in range(26):
                if dp[prev_end_char_code] == math.inf:
                    continue

                # Calculate the cost to add the current word
                cost_to_add = current_word_len
                if prev_end_char_code == current_word_start_char_code:
                    cost_to_add -= 1  # Overlap, reduce cost by 1

                # Update the minimum length for the current word ending with its last character
                next_dp[current_word_end_char_code] = min(
                    next_dp[current_word_end_char_code],
                    dp[prev_end_char_code] + cost_to_add
                )
            dp = next_dp

        # The minimum of all possible final lengths is the answer
        return min(dp)