from collections import Counter

def minPartitions(s: str) -> int:
    n = len(s)
    ans = n
    for i in range(1, 1 << (n - 1)):
        parts = []
        start = 0
        for j in range(n - 1):
            if (i >> j) & 1:
                parts.append(s[start:j + 1])
                start = j + 1
        parts.append(s[start:])

        valid = True
        for part in parts:
            counts = Counter(part)
            freqs = set(counts.values())
            if len(freqs) != 1:
                valid = False
                break

        if valid:
            ans = min(ans, len(parts))

    return ans