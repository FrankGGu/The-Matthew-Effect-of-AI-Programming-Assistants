function minimumOneBitOperations(n) {
    if (n === 0) return 0;
    const k = 31 - Math.floor(Math.log2(n));
    return (1 << k) - 1 - minimumOneBitOperations(n ^ (1 << k));
}