class Solution:
    def numberOfLines(self, source: str) -> int:
        lines = 1
        width = 0
        for c in source:
            if c == ' ':
                width += 1
            elif c == 'a' or c == 'b' or c == 'c' or c == 'd' or c == 'e' or c == 'f' or c == 'g' or c == 'h' or c == 'i' or c == 'j' or c == 'k' or c == 'l' or c == 'm' or c == 'n' or c == 'o' or c == 'p' or c == 'q' or c == 'r' or c == 's' or c == 't' or c == 'u' or c == 'v' or c == 'w' or c == 'x' or c == 'y' or c == 'z':
                width += 2
            else:
                width += 1
            if width > 100:
                lines += 1
                width = 0
        return lines