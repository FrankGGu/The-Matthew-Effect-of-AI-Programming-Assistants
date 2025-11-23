def minimumNumbers(n: int, k: int) -> int:
    if n == 0:
        return 0
    for i in range(1, 11):
        if (k * i) % 10 == n % 10 and k * i <= n:
            return k * i
    return -1