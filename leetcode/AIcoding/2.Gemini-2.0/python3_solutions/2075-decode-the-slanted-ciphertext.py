class Solution:
    def decodeCiphertext(self, encodedText: str, rows: int) -> str:
        n = len(encodedText)
        cols = n // rows
        matrix = [['' for _ in range(cols)] for _ in range(rows)]
        k = 0
        for i in range(rows):
            for j in range(cols):
                matrix[i][j] = encodedText[k]
                k += 1

        decoded = ""
        for j in range(cols):
            i = 0
            temp_j = j
            while i < rows and temp_j < cols:
                decoded += matrix[i][temp_j]
                i += 1
                temp_j += 1

        return decoded.rstrip()