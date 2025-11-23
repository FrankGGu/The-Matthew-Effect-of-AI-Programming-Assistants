class Solution:
    def findTheLongestGoodSubsequence(self, s: str, k: int) -> int:
        # dp[char_code][num_distinct] stores the maximum length of a good subsequence
        # ending with 'char_code' and having 'num_distinct' distinct characters.
        # char_code: 0-25 for 'a'-'z'
        # num_distinct: 1 to k
        dp = [[0] * (k + 1) for _ in range(26)]

        # max_len_val[num_distinct]: stores the maximum length found so far for subsequences
        #                            with 'num_distinct' distinct characters.
        # max_len_char[num_distinct]: stores the character code (0-25) that achieved
        #                             max_len_val[num_distinct].
        # second_max_len_val[num_distinct]: stores the second maximum length found so far
        #                                   for 'num_distinct' distinct characters.
        max_len_val = [0] * (k + 1)
        max_len_char = [-1] * (k + 1)  # -1 indicates no character has achieved this max yet
        second_max_len_val = [0] * (k + 1)

        overall_max_len = 0

        for char_s in s:
            curr_char_code = ord(char_s) - ord('a')

            # Iterate num_distinct from k down to 1.
            # This order is generally safer for DP updates, though for this specific problem
            # (where dependencies are on other characters' dp values), 1 to k would also work.
            for num_distinct in range(k, 0, -1):
                # Calculate length if curr_char_code is a NEW distinct character
                # This means we append curr_char_code to a subsequence that had (num_distinct - 1) distinct characters.
                val_if_c_is_new = 0
                if num_distinct == 1:
                    # If num_distinct is 1, the subsequence is just curr_char_code itself.
                    val_if_c_is_new = 1
                else:
                    max_len_from_prev_count = 0
                    # Find the maximum length from subsequences ending with a DIFFERENT character
                    # and having (num_distinct - 1) distinct characters.
                    if max_len_char[num_distinct - 1] != -1: # Check if any such subsequence exists
                        if max_len_char[num_distinct - 1] != curr_char_code:
                            max_len_from_prev_count = max_len_val[num_distinct - 1]
                        else:
                            max_len_from_prev_count = second_max_len_val[num_distinct - 1]

                    if max_len_from_prev_count > 0:
                        val_if_c_is_new = 1 + max_len_from_prev_count

                # Calculate length if curr_char_code is an EXISTING distinct character
                # This means we append curr_char_code to a subsequence that already had 'num_distinct' distinct characters.
                val_if_c_is_existing = 0
                max_len_from_same_count = 0
                # Find the maximum length from subsequences ending with a DIFFERENT character
                # and having 'num_distinct' distinct characters.
                if max_len_char[num_distinct] != -1: # Check if any such subsequence exists
                    if max_len_char[num_distinct] != curr_char_code:
                        max_len_from_same_count = max_len_val[num_distinct]
                    else:
                        max_len_from_same_count = second_max_len_val[num_distinct]

                if max_len_from_same_count > 0:
                    val_if_c_is_existing = 1 + max_len_from_same_count

                # The maximum length for a subsequence ending with curr_char_code
                # and having num_distinct characters, considering the current char_s.
                new_len_for_curr_char = max(val_if_c_is_new, val_if_c_is_existing)

                # Update dp table and global max/second_max values if a longer subsequence is found
                if new_len_for_curr_char > dp[curr_char_code][num_distinct]:
                    old_dp_val = dp[curr_char_code][num_distinct]
                    dp[curr_char_code][num_distinct] = new_len_for_curr_char

                    # Update global max/second max for this num_distinct
                    if curr_char_code == max_len_char[num_distinct]:
                        # If curr_char_code was already the character achieving the max length,
                        # and now it's even bigger, simply update the max.
                        max_len_val[num_distinct] = new_len_for_curr_char
                    else:
                        # If curr_char_code is not the current max char:
                        if new_len_for_curr_char > max_len_val[num_distinct]:
                            # New max found, old max becomes second max.
                            second_max_len_val[num_distinct] = max_len_val[num_distinct]
                            max_len_val[num_distinct] = new_len_for_curr_char
                            max_len_char[num_distinct] = curr_char_code
                        elif new_len_for_curr_char > second_max_len_val[num_distinct]:
                            # New second max found.
                            second_max_len_val[num_distinct] = new_len_for_curr_char

                overall_max_len = max(overall_max_len, dp[curr_char_code][num_distinct])

        return overall_max_len