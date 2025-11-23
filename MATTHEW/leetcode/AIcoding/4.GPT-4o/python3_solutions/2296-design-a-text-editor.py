class TextEditor:

    def __init__(self):
        self.text = []
        self.cursor = 0

    def addText(self, text: str) -> None:
        for char in text:
            self.text.insert(self.cursor, char)
            self.cursor += 1

    def deleteText(self, k: int) -> int:
        deleted = 0
        while deleted < k and self.cursor > 0:
            self.cursor -= 1
            del self.text[self.cursor]
            deleted += 1
        return deleted

    def cursorLeft(self, k: int) -> str:
        self.cursor = max(0, self.cursor - k)
        return self.get_text()

    def cursorRight(self, k: int) -> str:
        self.cursor = min(len(self.text), self.cursor + k)
        return self.get_text()

    def get_text(self) -> str:
        start = max(0, self.cursor - 10)
        return ''.join(self.text[start:self.cursor])