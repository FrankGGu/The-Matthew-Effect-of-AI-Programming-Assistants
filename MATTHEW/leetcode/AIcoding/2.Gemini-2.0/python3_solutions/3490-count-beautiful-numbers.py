def beautifulPartitions(n: int, k: int, minLength: int, ranges: list[list[int]]) -> int:
    MOD = 10**9 + 7
    ranges.sort()
    dp = [0] * n
    dp[n - 1] = 1
    for i in range(n - 2, -1, -1):
        if i + 1 + minLength > n:
            dp[i] = 0
            continue
        dp[i] = dp[i + 1]
        if i + minLength < n:
            dp[i] = (dp[i] + dp[i + minLength]) % MOD

    adj = [[] for _ in range(n)]
    for start, end in ranges:
        if start > 1:
            start -= 1
        adj[start - 1].append(end)

    merge = [False] * n
    for i in range(n):
        if adj[i]:
            max_reach = max(adj[i])
            if max_reach < n:
                merge[max_reach - 1] = True

    partitions = 1
    for i in range(n - 1):
        if merge[i]:
            partitions += 1

    if partitions < k:
        return 0

    def power(base, exp, mod):
        res = 1
        base %= mod
        while exp > 0:
            if exp % 2 == 1:
                res = (res * base) % mod
            base = (base * base) % mod
            exp //= 2
        return res

    return power(2, partitions - k, MOD)