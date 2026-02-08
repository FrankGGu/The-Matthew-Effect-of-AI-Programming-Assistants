var fourSumCount = function(A, B, C, D) {
    const countMap = new Map();
    let count = 0;

    for (const a of A) {
        for (const b of B) {
            countMap.set(a + b, (countMap.get(a + b) || 0) + 1);
        }
    }

    for (const c of C) {
        for (const d of D) {
            count += countMap.get(-(c + d)) || 0;
        }
    }

    return count;
};