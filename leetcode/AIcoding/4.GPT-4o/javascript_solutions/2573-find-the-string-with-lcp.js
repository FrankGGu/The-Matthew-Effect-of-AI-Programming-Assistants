var findLCP = function(A, B) {
    const n = A.length;
    const m = B.length;
    let lcp = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            let count = 0;
            while (i + count < n && j + count < m && A[i + count] === B[j + count]) {
                count++;
            }
            lcp[count]++;
        }
    }

    let maxLCP = 0;
    for (let i = 1; i <= n; i++) {
        if (lcp[i] > 0) {
            maxLCP = Math.max(maxLCP, i);
        }
    }

    return maxLCP;
};