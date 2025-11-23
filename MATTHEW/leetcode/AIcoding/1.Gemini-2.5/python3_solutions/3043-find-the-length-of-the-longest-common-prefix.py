from typing import List

class Solution:
    def longestCommonPrefix(self, strs: List[str]) -> str:
        if not strs:
            return ""

        # Take the first string as a reference
        first_str = strs[0]

        # Iterate through characters of the first string
        for i in range(len(first_str)):
            char = first_str[i]

            # Compare this character with the character at the same position in all other strings
            for j in range(1, len(strs)):
                # If we reach the end of any string OR the characters don't match
                if i == len(strs[j]) or strs[j][i] != char:
                    # The common prefix ends here
                    return first_str[:i]

        # If we complete the loop, it means the first string itself is the common prefix
        return first_str