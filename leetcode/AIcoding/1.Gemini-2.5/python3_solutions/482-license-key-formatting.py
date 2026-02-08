class Solution:
    def licenseKeyFormatting(self, s: str, k: int) -> str:
        cleaned_s_chars = []
        for char in s:
            if char != '-':
                cleaned_s_chars.append(char.upper())

        cleaned_s = "".join(cleaned_s_chars)

        if not cleaned_s:
            return ""

        formatted_parts = []
        current_group_chars = []
        char_count = 0

        for i in range(len(cleaned_s) - 1, -1, -1):
            current_group_chars.append(cleaned_s[i])
            char_count += 1

            if char_count == k:
                formatted_parts.append("".join(current_group_chars[::-1]))
                current_group_chars = []
                char_count = 0

        if current_group_chars:
            formatted_parts.append("".join(current_group_chars[::-1]))

        return "-".join(formatted_parts[::-1])