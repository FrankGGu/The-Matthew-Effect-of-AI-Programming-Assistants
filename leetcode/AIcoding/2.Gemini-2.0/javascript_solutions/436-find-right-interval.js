var findRightInterval = function(intervals) {
    const n = intervals.length;
    const result = new Array(n).fill(-1);
    const sortedIntervals = intervals.map((interval, index) => [interval, index]).sort((a, b) => a[0][0] - b[0][0]);

    for (let i = 0; i < n; i++) {
        const end = intervals[i][1];
        let left = 0;
        let right = n - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (sortedIntervals[mid][0][0] >= end) {
                result[i] = sortedIntervals[mid][1];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
    }

    return result;
};