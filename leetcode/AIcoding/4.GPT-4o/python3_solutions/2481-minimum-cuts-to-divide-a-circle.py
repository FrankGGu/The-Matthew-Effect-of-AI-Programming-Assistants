def findMinCuts(n: int) -> int:
    if n <= 1:
        return 0
    return n - 1