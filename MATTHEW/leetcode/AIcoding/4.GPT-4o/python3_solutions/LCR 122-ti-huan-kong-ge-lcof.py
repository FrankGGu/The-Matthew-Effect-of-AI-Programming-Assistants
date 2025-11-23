class Solution:
    def encrypt(self, text: str) -> str:
        if not text:
            return ""
        n = len(text)
        rows = int(n**0.5)
        cols = rows if rows * rows == n else rows + 1
        if rows * cols < n:
            rows += 1
        grid = [['' for _ in range(cols)] for _ in range(rows)]
        for i in range(n):
            grid[i // cols][i % cols] = text[i]
        encrypted = []
        for j in range(cols):
            for i in range(rows):
                if grid[i][j]:
                    encrypted.append(grid[i][j])
        return ''.join(encrypted)