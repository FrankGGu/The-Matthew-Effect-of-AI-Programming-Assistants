def passTheBall(n: int, k: int) -> int:
    return (k % (2 * n) + 1) if k % (2 * n) <= n else (2 * n - k % (2 * n) + 1)