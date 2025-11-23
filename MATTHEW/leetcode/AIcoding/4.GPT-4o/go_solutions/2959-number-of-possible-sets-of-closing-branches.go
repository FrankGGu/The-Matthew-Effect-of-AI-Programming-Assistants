func countPossibleSets(n int) int {
    const mod = 1_000_000_007
    res := 1

    for i := 1; i <= n; i++ {
        res = res * 2 % mod
    }

    return (res - 1 + mod) % mod
}