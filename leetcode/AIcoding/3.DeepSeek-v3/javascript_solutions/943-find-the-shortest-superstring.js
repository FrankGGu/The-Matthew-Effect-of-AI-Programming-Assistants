var shortestSuperstring = function(A) {
    const n = A.length;
    const graph = new Array(n).fill().map(() => new Array(n).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (i !== j) {
                graph[i][j] = calcOverlap(A[i], A[j]);
            }
        }
    }

    const dp = new Array(1 << n).fill().map(() => new Array(n).fill(0));
    const parent = new Array(1 << n).fill().map(() => new Array(n).fill(-1));

    for (let mask = 0; mask < (1 << n); mask++) {
        for (let bit = 0; bit < n; bit++) {
            if (!(mask & (1 << bit))) continue;
            let prevMask = mask ^ (1 << bit);
            if (prevMask === 0) continue;
            for (let i = 0; i < n; i++) {
                if (prevMask & (1 << i)) {
                    let val = dp[prevMask][i] + graph[i][bit];
                    if (val > dp[mask][bit]) {
                        dp[mask][bit] = val;
                        parent[mask][bit] = i;
                    }
                }
            }
        }
    }

    let max = -1;
    let last = -1;
    const fullMask = (1 << n) - 1;
    for (let i = 0; i < n; i++) {
        if (dp[fullMask][i] > max) {
            max = dp[fullMask][i];
            last = i;
        }
    }

    const path = [];
    let current = last;
    let mask = fullMask;

    while (current !== -1) {
        path.push(current);
        const prev = parent[mask][current];
        if (prev === -1) break;
        mask = mask ^ (1 << current);
        current = prev;
    }

    path.reverse();
    let res = A[path[0]];
    for (let i = 1; i < path.length; i++) {
        const overlap = graph[path[i-1]][path[i]];
        res += A[path[i]].substring(overlap);
    }

    return res;
};

function calcOverlap(a, b) {
    let max = Math.min(a.length, b.length);
    for (let i = max; i >= 0; i--) {
        if (a.endsWith(b.substring(0, i))) {
            return i;
        }
    }
    return 0;
}