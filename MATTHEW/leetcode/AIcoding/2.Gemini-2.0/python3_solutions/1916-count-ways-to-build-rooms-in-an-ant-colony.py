MOD = 10**9 + 7

def countWays(parents):
    n = len(parents)
    adj = [[] for _ in range(n)]
    for i in range(1, n):
        adj[parents[i]].append(i)

    sz = [0] * n

    def dfs(u):
        sz[u] = 1
        for v in adj[u]:
            dfs(v)
            sz[u] += sz[v]

    dfs(0)

    fact = [1] * (n + 1)
    for i in range(1, n + 1):
        fact[i] = (fact[i - 1] * i) % MOD

    def modInverse(n):
        return pow(n, MOD - 2, MOD)

    def nCr(n, r):
        if r > n:
            return 0
        num = fact[n]
        den = (fact[r] * fact[n - r]) % MOD
        return (num * modInverse(den)) % MOD

    ans = 1
    for i in range(n):
        ans = (ans * fact[sz[i] - 1]) % MOD

    invFactN = modInverse(fact[n - 1])

    return (fact[n - 1] * modInverse(ans)) % MOD