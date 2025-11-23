def circularGameLosers(n: int, k: int) -> List[int]:
    eliminated = [False] * n
    current = 0
    for i in range(n):
        current = (current + k - 1) % n
        while eliminated[current]:
            current = (current + 1) % n
        eliminated[current] = True
    return [i + 1 for i in range(n) if not eliminated[i]]