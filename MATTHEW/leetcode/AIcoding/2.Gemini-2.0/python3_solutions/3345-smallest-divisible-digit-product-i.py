def smallestNumber(n: int) -> int:
    if n == 1:
        return 1

    digits = []
    for i in range(9, 1, -1):
        while n % i == 0:
            digits.append(i)
            n //= i

    if n != 1:
        return -1

    digits.sort()
    return int("".join(map(str, digits)))