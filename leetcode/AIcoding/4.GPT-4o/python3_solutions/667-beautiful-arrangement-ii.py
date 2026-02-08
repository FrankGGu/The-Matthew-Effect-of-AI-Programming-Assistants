def constructArray(n: int, k: int) -> List[int]:
    result = []
    for i in range(1, k + 1):
        if i % 2 == 1:
            result.append(i // 2 + 1)
        else:
            result.append(k - i // 2 + 1)
    for i in range(k + 1, n + 1):
        result.append(i)
    return result