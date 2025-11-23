def checkDistances(s: str, distance: List[int]) -> bool:
    pos = {}
    for i, char in enumerate(s):
        if char in pos:
            if i - pos[char] - 1 != distance[ord(char) - ord('a')]:
                return False
        pos[char] = i
    return True