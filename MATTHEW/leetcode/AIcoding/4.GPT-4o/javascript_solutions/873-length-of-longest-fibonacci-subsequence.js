var lenLongestFibSubseq = function(A) {
    const set = new Set(A);
    const n = A.length;
    const dp = new Map();
    let maxLength = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            const a = A[i];
            const b = A[j];
            const c = a - b;
            if (set.has(c) && c < b) {
                const length = (dp.get(`${b},${c}`) || 2) + 1;
                dp.set(`${a},${b}`, length);
                maxLength = Math.max(maxLength, length);
            }
        }
    }
    return maxLength >= 3 ? maxLength : 0;
};