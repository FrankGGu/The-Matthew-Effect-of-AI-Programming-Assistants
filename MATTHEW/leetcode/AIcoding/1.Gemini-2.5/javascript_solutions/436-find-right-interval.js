var findRightInterval = function(intervals) {
    const n = intervals.length;
    if (n === 0) {
        return [];
    }

    const indexedIntervals = new Array(n);
    for (let i = 0; i < n; i++) {
        indexedIntervals[i] = [intervals[i][0], intervals[i][1], i];
    }

    indexedIntervals.sort((a, b) => a[0] - b[0]);

    const result = new Array(n).fill(-1);

    const findLowerBoundOriginalIndex = (sortedArr, target) => {
        let low = 0;
        let high = sortedArr.length - 1;
        let foundOriginalIndex = -1;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (sortedArr[mid][0] >= target) {
                foundOriginalIndex = sortedArr[mid][2];
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return foundOriginalIndex;
    };

    for (let i = 0; i < n; i++) {
        const currentEnd = intervals[i][1];
        result[i] = findLowerBoundOriginalIndex(indexedIntervals, currentEnd);
    }

    return result;
};