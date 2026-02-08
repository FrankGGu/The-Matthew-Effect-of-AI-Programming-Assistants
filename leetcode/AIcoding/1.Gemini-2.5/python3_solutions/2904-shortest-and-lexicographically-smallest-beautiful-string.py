import collections

class Solution:
    def shortestBeautifulSubstring(self, s: str, k: int) -> str:
        n = len(s)

        # Calculate half_len: the number of distinct characters required for the first half
        # of the palindrome (including the middle character if k is odd).
        # For example, if k=3, we need 2 distinct characters (c1, c2) for c1 c2 c1. half_len = (3+1)//2 = 2.
        # If k=4, we need 2 distinct characters (c1, c2) for c1 c2 c2 c1. half_len = (4+1)//2 = 2.
        half_len = (k + 1) // 2

        # Precompute suffix_distinct_chars: a bitmask where the i-th bit is set
        # if digit 'i' is present in the substring s[j:] (from index j to the end).
        # This helps in quickly checking if enough distinct characters are available later in s.
        suffix_distinct_chars = [0] * (n + 1)
        for i in range(n - 1, -1, -1):
            digit = int(s[i])
            suffix_distinct_chars[i] = suffix_distinct_chars[i+1] | (1 << digit)

        # Memoization table: dp[s_idx][current_b_len][used_mask] stores the lexicographically
        # smallest suffix of the first half of the palindrome (prefix) that can be formed.
        memo = {}

        # Helper function to count the number of set bits in a bitmask.
        def count_set_bits(mask):
            count = 0
            while mask > 0:
                mask &= (mask - 1)
                count += 1
            return count

        # Recursive function to find the lexicographically smallest prefix of the beautiful string.
        # s_idx: current index in the input string s we are considering.
        # current_b_len: number of characters already picked for the prefix.
        # used_mask: bitmask of digits already used in the prefix.
        def solve(s_idx, current_b_len, used_mask):
            # Base case 1: If we have picked enough characters for the prefix.
            if current_b_len == half_len:
                return ""

            # Base case 2: If we have exhausted s but still need characters for the prefix.
            # Return a sentinel string that is lexicographically larger than any possible valid string.
            if s_idx == n:
                return 'z' * (k + 1) 

            # Check memoization table.
            if (s_idx, current_b_len, used_mask) in memo:
                return memo[(s_idx, current_b_len, used_mask)]

            # Initialize best_res with a large sentinel string.
            best_res = 'z' * (k + 1) 

            # Iterate through possible characters s[i] from the current s_idx onwards
            # to be the next character in our prefix.
            for i in range(s_idx, n):
                digit = int(s[i])

                # If this digit has already been used in the current prefix, skip it
                # because all characters in the prefix must be distinct.
                if (used_mask >> digit) & 1:
                    continue

                # Check if it's possible to form the rest of the prefix after picking s[i].
                # We need 'remaining_needed' more distinct characters.
                remaining_needed = half_len - (current_b_len + 1)
                if remaining_needed > 0:
                    # Get the mask of distinct characters available in s[i+1:]
                    available_mask_after_i = suffix_distinct_chars[i+1]
                    # Filter out characters that are already used in the current prefix (including s[i])
                    possible_mask_for_rest = available_mask_after_i & (~(used_mask | (1 << digit)))

                    # If the number of distinct characters available is less than remaining_needed,
                    # then s[i] cannot be picked, so skip it.
                    if count_set_bits(possible_mask_for_rest) < remaining_needed:
                        continue

                # Recursively find the lexicographically smallest suffix for the rest of the prefix.
                res_suffix = solve(i + 1, current_b_len + 1, used_mask | (1 << digit))

                # If a valid suffix was found (not the sentinel string),
                # construct the current candidate prefix and compare it with best_res.
                if res_suffix != 'z' * (k + 1):
                    current_candidate = s[i] + res_suffix
                    if current_candidate < best_res:
                        best_res = current_candidate

            # Store and return the result for the current state.
            memo[(s_idx, current_b_len, used_mask)] = best_res
            return best_res

        # Find the lexicographically smallest prefix for the beautiful string.
        prefix = solve(0, 0, 0)

        # If no valid prefix was found, it means no beautiful string exists.
        if prefix == 'z' * (k + 1):
            return ""

        # Construct the full palindrome from the found prefix.
        result = prefix
        if k % 2 == 1:
            # For odd k, the middle character is prefix[-1].
            # The reversed part is prefix excluding the last character, then reversed.
            reversed_part = prefix[:-1][::-1]
        else:
            # For even k, there is no middle character.
            # The reversed part is the entire prefix, reversed.
            reversed_part = prefix[::-1]

        result += reversed_part

        return result