class Solution:
    def decodeCiphertext(self, encodedText: str, rows: int) -> str:
        if not encodedText or rows == 0:
            return ""
        n = len(encodedText)
        cols = n // rows
        res = []
        for i in range(cols):
            for j in range(rows):
                if i + j < cols:
                    res.append(encodedText[j * cols + i + j])
        return ''.join(res).rstrip()