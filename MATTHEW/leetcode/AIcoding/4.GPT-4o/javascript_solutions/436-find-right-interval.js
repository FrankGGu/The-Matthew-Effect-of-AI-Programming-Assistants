var findRightInterval = function(intervals) {
    const n = intervals.length;
    const result = new Array(n).fill(-1);
    const startPoints = intervals.map((interval, index) => [interval[0], index]);

    startPoints.sort((a, b) => a[0] - b[0]);

    for (let i = 0; i < n; i++) {
        const target = intervals[i][1];
        let left = 0, right = n - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (startPoints[mid][0] >= target) {
                result[i] = startPoints[mid][1];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
    }

    return result;
};