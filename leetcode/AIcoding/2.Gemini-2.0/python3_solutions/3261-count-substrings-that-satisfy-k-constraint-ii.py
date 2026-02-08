def count_substrings(s: str, k: int) -> int:
    n = len(s)
    count = 0
    for i in range(n):
        freq = {}
        max_freq = 0
        for j in range(i, n):
            char = s[j]
            freq[char] = freq.get(char, 0) + 1
            max_freq = max(max_freq, freq[char])
            if (j - i + 1) - max_freq <= k:
                count += 1
    return count