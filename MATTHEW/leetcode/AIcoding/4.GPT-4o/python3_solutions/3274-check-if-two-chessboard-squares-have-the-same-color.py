def squareIsWhite(coordinates: str) -> bool:
    return (ord(coordinates[0]) - ord('a') + int(coordinates[1])) % 2 == 1