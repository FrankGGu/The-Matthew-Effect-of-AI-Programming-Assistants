class Solution:
    def minCharacters(self, a: str, b: str) -> int:
        def count_changes_to_char(c):
            return sum((ord(x) - ord('a') + 1) for x in a) + sum((ord(y) - ord('a') + 1) for y in b) - (len(a) + len(b)) * (ord(c) - ord('a') + 1)

        res = float('inf')
        for c in range(26):
            char = chr(c + ord('a'))
            res = min(res, count_changes_to_char(char))

        return res