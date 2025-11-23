function minimumOperationsToMakeASpecialNumber(s) {
    const n = s.length;
    let minOps = Infinity;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const num = s.substring(i, j + 1);
            if (num.length > 4) continue;
            const val = parseInt(num, 10);
            if (val % 25 === 0) {
                const ops = (n - 1 - j) + (i);
                minOps = Math.min(minOps, ops);
            }
        }
    }

    if (minOps !== Infinity) return minOps;
    return n;
}