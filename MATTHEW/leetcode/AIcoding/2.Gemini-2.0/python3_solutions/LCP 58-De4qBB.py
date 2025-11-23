MOD = 10**9 + 7

def solve():
    n = int(input())

    single = pow(2, n, MOD)

    L_shape = pow(single - 2, 2, MOD)

    return (single + L_shape) % MOD