import re

class Solution:
    def splitWordsBySeparator(self, words: list[str], separators: list[str]) -> list[str]:
        result = []

        # Escape each separator character to handle regex special characters
        escaped_separators = [re.escape(s) for s in separators]

        # Create a regex pattern to split by any of the escaped separators
        # The pattern will look like "sep1|sep2|sep3"
        pattern = "|".join(escaped_separators)

        for word in words:
            # Split the word using the constructed regex pattern
            split_parts = re.split(pattern, word)

            # Add non-empty parts to the result list
            for part in split_parts:
                if part:  # Check if the string is not empty
                    result.append(part)

        return result