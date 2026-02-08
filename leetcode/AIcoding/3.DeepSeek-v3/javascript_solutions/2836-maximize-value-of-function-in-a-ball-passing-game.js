var getMaxFunctionValue = function(receiver, k) {
    const n = receiver.length;
    const LOG = 35;
    const up = Array.from({ length: n }, () => Array(LOG).fill(0));
    const sum = Array.from({ length: n }, () => Array(LOG).fill(0));

    for (let i = 0; i < n; ++i) {
        up[i][0] = receiver[i];
        sum[i][0] = receiver[i];
    }

    for (let j = 1; j < LOG; ++j) {
        for (let i = 0; i < n; ++i) {
            up[i][j] = up[up[i][j - 1]][j - 1];
            sum[i][j] = sum[i][j - 1] + sum[up[i][j - 1]][j - 1];
        }
    }

    let max = 0;
    for (let i = 0; i < n; ++i) {
        let current = i;
        let total = i;
        let remaining = k;
        for (let j = 0; j < LOG; ++j) {
            if (remaining & (1 << j)) {
                total += sum[current][j];
                current = up[current][j];
                remaining -= (1 << j);
            }
        }
        max = Math.max(max, total);
    }

    return max;
};