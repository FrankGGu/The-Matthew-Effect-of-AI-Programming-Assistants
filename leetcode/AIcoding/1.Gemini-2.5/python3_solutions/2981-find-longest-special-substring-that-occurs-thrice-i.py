class Solution:
    def longestSpecialSubstring(self, s: str) -> int:
        n = len(s)

        # Iterate through possible lengths from n down to 1
        for length in range(n, 0, -1):
            # For each length, check all possible single characters 'a' through 'z'
            for char_code in range(ord('a'), ord('z') + 1):
                char = chr(char_code)

                # Construct the special substring (e.g., "aaa" for char='a', length=3)
                special_substring = char * length

                # Count occurrences of this special_substring in s
                count = 0
                # Iterate through all possible starting positions for the substring
                for i in range(n - length + 1):
                    # Check if the substring from s matches our special_substring
                    if s[i : i + length] == special_substring:
                        count += 1

                # If the special substring occurs at least 3 times,
                # this is the longest possible length we could find, so return it.
                if count >= 3:
                    return length

        # According to problem constraints, a valid substring is guaranteed to exist,
        # so this line should theoretically not be reached.
        return -1