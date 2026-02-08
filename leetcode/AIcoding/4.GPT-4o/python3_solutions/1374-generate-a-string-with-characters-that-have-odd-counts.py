def generateTheString(n: int) -> str:
    if n % 2 == 0:
        return 'a' * (n - 1) + 'b'
    else:
        return 'a' * n