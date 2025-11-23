class Solution:
    def countAsterisks(self, s: str) -> int:
        count = 0
        in_pair = False
        for char in s:
            if char == '|':
                in_pair = not in_pair
            elif char == '*' and not in_pair:
                count += 1
        return count