function kthSymbol(n, k) {
    if (n === 1) return 0;
    const parent = kthSymbol(n - 1, Math.ceil(k / 2));
    if (k % 2 === 1) {
        return parent === 0 ? 0 : 1;
    } else {
        return parent === 0 ? 1 : 0;
    }
}