def divideString(s: str, k: int, fill: str) -> List[str]:
    n = len(s)
    result = []

    for i in range(0, n, k):
        group = s[i:i+k]
        if len(group) < k:
            group += fill * (k - len(group))
        result.append(group)

    return result