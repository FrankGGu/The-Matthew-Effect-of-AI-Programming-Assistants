class TextEditor:

    def __init__(self):
        self.left = []
        self.right = []

    def addText(self, text: str) -> None:
        for c in text:
            self.left.append(c)

    def deleteText(self, k: int) -> int:
        cnt = 0
        while self.left and cnt < k:
            self.left.pop()
            cnt += 1
        return cnt

    def cursorLeft(self, k: int) -> str:
        while self.left and k > 0:
            self.right.append(self.left.pop())
            k -= 1
        return self._getLeftChars()

    def cursorRight(self, k: int) -> str:
        while self.right and k > 0:
            self.left.append(self.right.pop())
            k -= 1
        return self._getLeftChars()

    def _getLeftChars(self) -> str:
        return ''.join(self.left[-10:])