class Solution:
    def findOriginalString(self, typed: str) -> str:
        if not typed:
            return ""

        original_chars = []
        for char in typed:
            if not original_chars or original_chars[-1] != char:
                original_chars.append(char)

        return "".join(original_chars)