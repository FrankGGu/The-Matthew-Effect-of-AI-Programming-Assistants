class Solution:
    def canConvert(self, str1: str, str2: str) -> bool:
        if str1 == str2:
            return True

        if len(str1) != len(str2):
            return False

        mapping = {}
        for i in range(len(str1)):
            char1 = str1[i]
            char2 = str2[i]
            if char1 in mapping:
                if mapping[char1] != char2:
                    return False
            else:
                mapping[char1] = char2

        # If str1 is different from str2, and all 26 lowercase English characters
        # are present in str2, then there's no "free" character to use as a
        # temporary placeholder for cyclic transformations.
        # For example, "abcdefghijklmnopqrstuvwxyz" to "bcdefghijklmnopqrstuvwxyza"
        # requires 'a' to become 'b', 'b' to become 'c', ..., 'z' to become 'a'.
        # To change 'a' to 'b', we'd need to temporarily change 'a' to some 'temp_char',
        # then 'b' to 'c', etc., and finally 'temp_char' to 'b'.
        # If all 26 characters are used in str2, no 'temp_char' is available.
        if len(set(str2)) == 26:
            return False

        return True