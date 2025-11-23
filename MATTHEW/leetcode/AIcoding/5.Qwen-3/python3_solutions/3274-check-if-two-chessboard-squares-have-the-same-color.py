class Solution:
    def squareIsWhite(self, coordinates: str) -> bool:
        x, y = coordinates[0], coordinates[1]
        return (ord(x) - ord('a') + int(y)) % 2 == 1