function numWays(n) {
    if (n === 0) return 0;
    if (n === 1) return 6;

    let a = 6, b = 6;
    for (let i = 2; i <= n; i++) {
        let c = (a * 2 + b * 2) % (10**9 + 7);
        a = b;
        b = c;
    }
    return b;
}