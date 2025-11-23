function kSum(A, K) {
    const n = A.length;
    A.sort((a, b) => a - b);
    const result = [];

    const backtrack = (start, path, target, k) => {
        if (path.length === k) {
            if (target === 0) {
                result.push([...path]);
            }
            return;
        }
        for (let i = start; i < n; i++) {
            if (i > start && A[i] === A[i - 1]) continue;
            if (A[i] > target) break;
            path.push(A[i]);
            backtrack(i + 1, path, target - A[i], k);
            path.pop();
        }
    };

    for (let k = 1; k <= K; k++) {
        backtrack(0, [], K, k);
    }

    return result;
}