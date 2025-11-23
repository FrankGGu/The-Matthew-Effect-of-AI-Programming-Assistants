def decodeCiphertext(self, encodedText: str, rows: int) -> str:
    if rows == 0 or not encodedText:
        return ""

    n = len(encodedText)
    cols = n // rows
    decoded = []

    for c in range(cols):
        for r in range(rows):
            if c + r < cols:
                decoded.append(encodedText[r * cols + c + r])

    result = ''.join(decoded).rstrip()
    return result