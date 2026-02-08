class Solution:
    def convertToTitle(self, columnNumber: int) -> str:
        title = []
        while columnNumber > 0:
            columnNumber -= 1
            title.append(chr(columnNumber % 26 + ord('A')))
            columnNumber //= 26
        return ''.join(reversed(title))