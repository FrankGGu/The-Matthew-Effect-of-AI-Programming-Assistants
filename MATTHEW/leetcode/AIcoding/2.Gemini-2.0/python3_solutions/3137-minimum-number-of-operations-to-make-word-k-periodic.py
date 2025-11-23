def minOperations(word: str, k: int) -> int:
    n = len(word)
    if n % k != 0:
        return -1

    periods = n // k
    operations = 0
    for i in range(k):
        counts = {}
        for j in range(periods):
            char = word[i + j * k]
            counts[char] = counts.get(char, 0) + 1

        max_count = 0
        for count in counts.values():
            max_count = max(max_count, count)

        operations += periods - max_count

    return operations