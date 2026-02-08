def firstUniqChar(s: str) -> int:
    counts = {}
    for char in s:
        counts[char] = counts.get(char, 0) + 1

    for i, char in enumerate(s):
        if counts[char] == 1:
            return i

    return -1