class TextEditor:

    def __init__(self):
        self.left = []
        self.right = []

    def addText(self, text: str) -> None:
        self.left.extend(list(text))

    def deleteText(self, k: int) -> int:
        deleted_count = 0
        while k > 0 and self.left:
            self.left.pop()
            deleted_count += 1
            k -= 1
        return deleted_count

    def cursorLeft(self, k: int) -> str:
        while k > 0 and self.left:
            self.right.append(self.left.pop())
            k -= 1

        start_index = max(0, len(self.left) - 10)
        return "".join(self.left[start_index:])

    def cursorRight(self, k: int) -> str:
        while k > 0 and self.right:
            self.left.append(self.right.pop())
            k -= 1

        start_index = max(0, len(self.left) - 10)
        return "".join(self.left[start_index:])