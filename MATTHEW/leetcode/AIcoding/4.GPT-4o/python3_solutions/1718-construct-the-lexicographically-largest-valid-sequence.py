def constructLargestSequence(n: int) -> str:
    if n % 2 == 0:
        return ''.join(str(i) for i in range(n, 0, -1))
    else:
        return ''.join(str(i) for i in range(n, 0, -1)) + '1'