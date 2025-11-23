class TextEditor:
    def __init__(self):
        self.text = ""
        self.cursor = 0

    def addText(self, text: str) -> None:
        self.text = self.text[:self.cursor] + text + self.text[self.cursor:]
        self.cursor += len(text)

    def deleteText(self) -> int:
        deleted = self.cursor
        self.text = self.text[:self.cursor] + self.text[self.cursor:]
        self.cursor = 0
        return deleted

    def cursorLeft(self, k: int) -> str:
        self.cursor = max(0, self.cursor - k)
        return self.text[max(0, self.cursor - 10):self.cursor]

    def cursorRight(self, k: int) -> str:
        self.cursor = min(len(self.text), self.cursor + k)
        return self.text[max(0, self.cursor - 10):self.cursor]