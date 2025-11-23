def closestPrimes(left: int, right: int) -> list[int]:
    def is_prime(n):
        if n <= 1:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True

    primes = []
    for i in range(left, right + 1):
        if is_prime(i):
            primes.append(i)

    if len(primes) < 2:
        return [-1, -1]

    min_diff = float('inf')
    result = [-1, -1]
    for i in range(len(primes) - 1):
        diff = primes[i+1] - primes[i]
        if diff < min_diff:
            min_diff = diff
            result = [primes[i], primes[i+1]]

    return result