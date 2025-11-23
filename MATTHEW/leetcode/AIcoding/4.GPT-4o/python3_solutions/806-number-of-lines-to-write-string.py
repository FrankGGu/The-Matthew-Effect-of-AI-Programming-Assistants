def numberOfLines(widths, s: str) -> List[int]:
    total_width = 0
    lines = 1

    for char in s:
        total_width += widths[ord(char) - ord('a')]
        if total_width > 100:
            lines += 1
            total_width = widths[ord(char) - ord('a')]

    return [lines, total_width]