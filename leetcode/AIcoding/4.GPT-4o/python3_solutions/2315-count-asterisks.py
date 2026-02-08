class Solution:
    def countAsterisks(self, s: str) -> int:
        count = 0
        inside_bar = False

        for char in s:
            if char == '|':
                inside_bar = not inside_bar
            elif char == '*' and not inside_bar:
                count += 1

        return count