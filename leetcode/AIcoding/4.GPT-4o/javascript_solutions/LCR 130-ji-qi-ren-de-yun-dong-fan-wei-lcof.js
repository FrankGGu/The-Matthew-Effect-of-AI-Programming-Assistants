function minOperations(n, x) {
    let total = 0;
    let result = Infinity;
    const prefix = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        total += i;
        prefix[i] = total;
    }

    for (let i = 0; i <= n; i++) {
        if (x - prefix[i] >= 0 && (i === 0 || x - prefix[i] <= total - prefix[n - i])) {
            result = Math.min(result, n - i);
        }
    }

    return result === Infinity ? -1 : result;
}