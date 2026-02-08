def maxFreq(s: str, maxLetters: int, minSize: int, maxSize: int) -> int:
    count = {}
    for i in range(len(s) - minSize + 1):
        sub = s[i:i + minSize]
        if len(set(sub)) <= maxLetters:
            count[sub] = count.get(sub, 0) + 1

    if not count:
        return 0

    return max(count.values())