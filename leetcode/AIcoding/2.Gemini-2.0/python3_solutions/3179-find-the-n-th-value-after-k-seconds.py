def findTheNthValueAfterKSeconds(n: int, k: int) -> int:
    return (n + k - 1) % 8 + 1