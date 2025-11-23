function numWays(n, k) {
    if (n === 0) return 0;
    if (n === 1) return k;
    let same = k;
    let diff = k * (k - 1);
    for (let i = 2; i < n; i++) {
        let temp = diff;
        diff = (same + diff) * (k - 1);
        same = temp;
    }
    return same + diff;
}