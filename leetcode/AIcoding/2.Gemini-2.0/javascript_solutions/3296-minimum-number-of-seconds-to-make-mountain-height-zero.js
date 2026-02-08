var minimumSeconds = function(mountain) {
    const n = mountain.length;
    const leftMap = new Map();
    const rightMap = new Map();
    for (let i = 0; i < n; i++) {
        if (!leftMap.has(mountain[i])) {
            leftMap.set(mountain[i], i);
        }
    }
    for (let i = n - 1; i >= 0; i--) {
        if (!rightMap.has(mountain[i])) {
            rightMap.set(mountain[i], i);
        }
    }
    const counts = new Map();
    for (const [val, left] of leftMap) {
        const right = rightMap.get(val);
        const len = right - left + 1;
        if (!counts.has(len)) {
            counts.set(len, 0);
        }
        counts.set(len, counts.get(len) + 1);
    }
    let maxCount = 0;
    for (const count of counts.values()) {
        maxCount = Math.max(maxCount, count);
    }
    return n - maxCount;
};