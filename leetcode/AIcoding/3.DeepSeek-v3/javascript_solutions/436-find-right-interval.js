var findRightInterval = function(intervals) {
    const n = intervals.length;
    const startIndices = new Map();
    for (let i = 0; i < n; i++) {
        startIndices.set(intervals[i][0], i);
    }

    const sortedStarts = [...intervals].map(interval => interval[0]).sort((a, b) => a - b);
    const result = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        const end = intervals[i][1];
        let left = 0, right = n - 1;
        let found = -1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (sortedStarts[mid] >= end) {
                found = sortedStarts[mid];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        if (found !== -1) {
            result[i] = startIndices.get(found);
        }
    }

    return result;
};