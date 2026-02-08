function numWays(n, k) {
    if (n === 0) return 1;
    if (n === 1) return k;

    let same = 0;
    let diff = k;

    for (let i = 2; i <= n; i++) {
        const temp = diff;
        diff = (same + diff) * (k - 1);
        same = temp;
    }

    return same + diff;
}