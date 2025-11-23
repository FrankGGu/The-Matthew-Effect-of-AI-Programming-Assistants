function commonPrefixes(A, B) {
    const n = A.length;
    const result = [];
    const seenA = new Set();
    const seenB = new Set();

    for (let i = 0; i < n; i++) {
        seenA.add(A[i]);
        seenB.add(B[i]);
        let count = 0;
        for (let j = 1; j <= i + 1; j++) {
            if (seenA.has(j) && seenB.has(j)) {
                count++;
            }
        }
        result.push(count);
    }

    return result;
}