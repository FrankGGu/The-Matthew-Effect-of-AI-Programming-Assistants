function shortestSuperstring(A) {
    const n = A.length;
    const dp = Array.from({ length: 1 << n }, () => Array(n).fill(Infinity));
    const parent = Array.from({ length: 1 << n }, () => Array(n).fill(-1));

    for (let i = 0; i < n; i++) {
        dp[1 << i][i] = A[i].length;
    }

    for (let mask = 1; mask < (1 << n); mask++) {
        for (let i = 0; i < n; i++) {
            if (!(mask & (1 << i))) continue;

            for (let j = 0; j < n; j++) {
                if (i === j || !(mask & (1 << j))) continue;
                const overlap = getOverlap(A[i], A[j]);
                const newMask = mask ^ (1 << i);
                const newLength = dp[newMask][j] + A[i].length - overlap;

                if (newLength < dp[mask][i]) {
                    dp[mask][i] = newLength;
                    parent[mask][i] = j;
                }
            }
        }
    }

    let minLength = Infinity;
    let lastIndex = -1;
    for (let i = 0; i < n; i++) {
        if (dp[(1 << n) - 1][i] < minLength) {
            minLength = dp[(1 << n) - 1][i];
            lastIndex = i;
        }
    }

    const result = [];
    let mask = (1 << n) - 1;

    while (lastIndex !== -1) {
        result.push(lastIndex);
        const nextIndex = parent[mask][lastIndex];
        mask ^= (1 << lastIndex);
        lastIndex = nextIndex;
    }

    result.reverse();

    let superstring = A[result[0]];
    for (let i = 1; i < result.length; i++) {
        const overlap = getOverlap(A[result[i - 1]], A[result[i]]);
        superstring += A[result[i]].slice(overlap);
    }

    return superstring;
}

function getOverlap(a, b) {
    const maxOverlap = Math.min(a.length, b.length);
    for (let i = maxOverlap; i > 0; i--) {
        if (a.slice(-i) === b.slice(0, i)) {
            return i;
        }
    }
    return 0;
}