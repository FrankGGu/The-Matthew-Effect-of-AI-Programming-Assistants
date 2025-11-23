def minDeletions(s: str, k: int) -> int:
    from collections import Counter

    freq = Counter(s)
    freq_values = sorted(freq.values(), reverse=True)

    if len(freq_values) <= k:
        return 0

    return sum(freq_values[k:])