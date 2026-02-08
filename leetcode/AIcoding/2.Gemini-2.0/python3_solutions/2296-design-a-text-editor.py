class TextEditor:

    def __init__(self):
        self.text = ""
        self.cursor = 0

    def write(self, text: str) -> None:
        self.text = self.text[:self.cursor] + text + self.text[self.cursor:]
        self.cursor += len(text)

    def moveCursorLeft(self, k: int) -> str:
        self.cursor = max(0, self.cursor - k)
        return self.text[max(0, self.cursor - 10):self.cursor]

    def moveCursorRight(self, k: int) -> str:
        self.cursor = min(len(self.text), self.cursor + k)
        return self.text[max(0, self.cursor - 10):self.cursor]

    def deleteText(self, k: int) -> int:
        deleted = min(k, self.cursor)
        self.text = self.text[:self.cursor - deleted] + self.text[self.cursor:]
        self.cursor -= deleted
        return deleted