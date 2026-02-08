var findShortestSuperstring = function(A) {
    const n = A.length;
    const overlap = Array.from({ length: n }, () => Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                for (let k = 1; k <= Math.min(A[i].length, A[j].length); k++) {
                    if (A[i].slice(-k) === A[j].slice(0, k)) {
                        overlap[i][j] = k;
                    }
                }
            }
        }
    }

    const dp = Array(1 << n).fill(Infinity);
    const parent = Array(1 << n).fill(-1);
    dp[0] = 0;

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if (mask & (1 << i)) continue;
            const newMask = mask | (1 << i);
            const newLength = dp[mask] + A[i].length - overlap[i][mask] || 0;
            if (newLength < dp[newMask]) {
                dp[newMask] = newLength;
                parent[newMask] = mask;
            }
        }
    }

    let minLength = Infinity;
    let endMask = 0;
    for (let mask = 0; mask < (1 << n); mask++) {
        if (dp[mask] < minLength) {
            minLength = dp[mask];
            endMask = mask;
        }
    }

    let result = '';
    const used = Array(n).fill(false);
    while (endMask > 0) {
        const prevMask = parent[endMask];
        const lastIndex = endMask ^ prevMask;
        const i = Math.log2(lastIndex);
        if (prevMask === 0) {
            result = A[i] + result;
        } else {
            const overlapLen = overlap[i][prevMask];
            result = A[i].slice(overlapLen) + result;
        }
        endMask = prevMask;
    }

    return result;
};