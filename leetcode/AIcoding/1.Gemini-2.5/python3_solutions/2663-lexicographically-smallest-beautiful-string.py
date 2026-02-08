class Solution:
    def smallestBeautifulString(self, s: str, k: int) -> str:
        n = len(s)
        res = list(s)

        k_char_limit_ord = ord('a') + k - 1

        # Step 1: Make res a palindrome based on s's left half.
        # This creates the lexicographically smallest palindrome that starts with s's prefix.
        for j in range((n + 1) // 2):
            res[n - 1 - j] = res[j]

        # Step 2: Check if this initial palindrome `res` is valid (all chars <= k)
        # and lexicographically greater than or equal to `s`.
        # If it is, this is the smallest such string.
        is_valid_k = True
        for char_val in res:
            if ord(char_val) > k_char_limit_ord:
                is_valid_k = False
                break

        if is_valid_k and "".join(res) >= s:
            return "".join(res)

        # Step 3: If the initial palindrome `res` is not valid or `res < s`,
        # we need to find the next lexicographically smallest palindrome.
        # We do this by trying to increment characters from the rightmost position
        # of the first half (most significant for lexicographical ordering).

        # Start from the rightmost character of the first half.
        idx = (n - 1) // 2 

        while idx >= 0:
            current_char_ord = ord(res[idx])

            # Try to increment res[idx].
            # We must start trying from `current_char_ord + 1` because we already know
            # that `res` (with `res[idx]` as `current_char_ord`) is either too small or invalid.
            # So we must make it strictly larger.
            for char_code in range(current_char_ord + 1, k_char_limit_ord + 1):
                res[idx] = chr(char_code)
                res[n - 1 - idx] = chr(char_code)

                # Fill the rest of the first half (to the right of `idx`) with 'a's
                # to make the resulting palindrome lexicographically smallest.
                for j in range(idx + 1, (n + 1) // 2):
                    res[j] = 'a'
                    res[n - 1 - j] = 'a'

                return "".join(res)

            # If we couldn't increment res[idx] (either it's already k_char_limit_ord
            # or incrementing it goes beyond k_char_limit_ord), we need to carry over.
            # Set res[idx] and res[n-1-idx] to 'a' (smallest possible) and move to the left.
            res[idx] = 'a'
            res[n - 1 - idx] = 'a'
            idx -= 1

        # If the loop finishes, it means we tried to increment all characters from (n-1)//2 down to 0
        # and couldn't find a valid palindrome.
        return ""