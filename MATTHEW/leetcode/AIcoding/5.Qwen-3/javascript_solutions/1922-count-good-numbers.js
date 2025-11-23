function countGoodNumbers(n) {
    const MOD = 10 ** 9 + 7;
    const evenCount = Math.pow(5, n);
    const oddCount = Math.pow(4, n);
    return (evenCount * oddCount) % MOD;
}