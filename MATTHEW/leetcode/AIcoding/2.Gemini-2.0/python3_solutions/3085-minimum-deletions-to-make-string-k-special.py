def minDeletions(s: str, k: int) -> int:
    freq = {}
    for char in s:
        freq[char] = freq.get(char, 0) + 1

    counts = sorted(freq.values(), reverse=True)

    deletions = 0
    seen = set()

    for count in counts:
        while count > 0 and count in seen:
            count -= 1
            deletions += 1
        seen.add(count)

    return deletions