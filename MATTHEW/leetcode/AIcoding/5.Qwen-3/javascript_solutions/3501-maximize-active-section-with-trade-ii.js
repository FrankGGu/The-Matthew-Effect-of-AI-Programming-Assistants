function maxActiveSections(trades) {
    const n = trades.length;
    const left = new Array(n).fill(0);
    const right = new Array(n).fill(0);
    let count = 0;

    for (let i = 0; i < n; i++) {
        if (trades[i] === 'A') {
            count++;
        } else {
            count = 0;
        }
        left[i] = count;
    }

    count = 0;
    for (let i = n - 1; i >= 0; i--) {
        if (trades[i] === 'A') {
            count++;
        } else {
            count = 0;
        }
        right[i] = count;
    }

    let max = 0;
    for (let i = 0; i < n; i++) {
        max = Math.max(max, left[i] + right[i]);
    }

    return max;
}