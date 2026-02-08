def count_ways(queries, num):
    MOD = 10**9 + 7
    MAX_N = 10001
    fact = [1] * (MAX_N + 1)
    inv = [1] * (MAX_N + 1)
    for i in range(2, MAX_N + 1):
        fact[i] = (fact[i - 1] * i) % MOD
        inv[i] = pow(fact[i], MOD - 2, MOD)

    def combinations(n, k):
        if k < 0 or k > n:
            return 0
        return (fact[n] * inv[k] % MOD) * inv[n - k] % MOD

    primes = []
    temp = num
    i = 2
    while i * i <= temp:
        if temp % i == 0:
            primes.append(i)
            while temp % i == 0:
                temp //= i
        i += 1
    if temp > 1:
        primes.append(temp)

    result = []
    for n, k in queries:
        ways = 1
        for _ in primes:
            ways = (ways * combinations(n + k - 1, n)) % MOD
        result.append(ways)
    return result