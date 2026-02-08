def maximumPrimeDifference(nums: list[int]) -> int:
    def is_prime(n):
        if n <= 1:
            return False
        for i in range(2, int(n**0.5) + 1):
            if n % i == 0:
                return False
        return True

    primes = sorted([num for num in nums if is_prime(num)])
    if len(primes) < 2:
        return -1
    return primes[-1] - primes[0]