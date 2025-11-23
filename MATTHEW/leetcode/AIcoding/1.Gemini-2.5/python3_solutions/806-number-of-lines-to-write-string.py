class Solution:
    def numberOfLines(self, widths: list[int], s: str) -> list[int]:
        lines = 1
        current_line_width = 0
        max_width = 100

        for char_code in s:
            char_width = widths[ord(char_code) - ord('a')]
            if current_line_width + char_width > max_width:
                lines += 1
                current_line_width = char_width
            else:
                current_line_width += char_width

        return [lines, current_line_width]