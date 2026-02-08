class Solution:
    def addMinimum(self, s: str) -> int:
        count = 0
        expected = 'a'

        for char in s:
            while expected != char:
                count += 1
                expected = chr(ord(expected) + 1) if expected != 'c' else 'a'
            expected = chr(ord(expected) + 1) if expected != 'c' else 'a'

        while expected != 'a':
            count += 1
            expected = chr(ord(expected) + 1) if expected != 'c' else 'a'

        return count