def distinctEchoSubstrings(text: str) -> int:
    n = len(text)
    seen = set()
    for length in range(1, n // 2 + 1):
        for i in range(n - 2 * length + 1):
            substring = text[i:i + length]
            if text[i + length:i + 2 * length] == substring:
                seen.add(substring)
    return len(seen)