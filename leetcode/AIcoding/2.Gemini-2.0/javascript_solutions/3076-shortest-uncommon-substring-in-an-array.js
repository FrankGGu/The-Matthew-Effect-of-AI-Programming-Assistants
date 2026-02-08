var shortestSubsequence = function(A) {
    const n = A.length;
    let minLen = Infinity;

    for (let len = 1; len <= 100; len++) {
        for (let i = 0; i < n; i++) {
            for (let j = 0; j <= A[i].length - len; j++) {
                const sub = A[i].substring(j, j + len);
                let found = false;
                for (let k = 0; k < n; k++) {
                    if (i === k) continue;
                    if (A[k].includes(sub)) {
                        found = true;
                        break;
                    }
                }
                if (!found) {
                    minLen = Math.min(minLen, len);
                }
            }
        }
        if (minLen !== Infinity) break;
    }

    return minLen === Infinity ? -1 : minLen;
};