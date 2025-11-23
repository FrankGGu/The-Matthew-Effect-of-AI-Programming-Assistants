var maxTwoEvents = function(events) {
    events.sort((a, b) => a[0] - b[0]);

    const n = events.length;
    const suffixMaxValues = new Array(n);

    suffixMaxValues[n - 1] = events[n - 1][2];
    for (let i = n - 2; i >= 0; i--) {
        suffixMaxValues[i] = Math.max(events[i][2], suffixMaxValues[i + 1]);
    }

    let maxOverallValue = 0;

    function lowerBound(events, targetStartTime) {
        let low = 0;
        let high = events.length; 
        while (low < high) {
            let mid = Math.floor((low + high) / 2);
            if (events[mid][0] < targetStartTime) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    for (let i = 0; i < n; i++) {
        const [s1, e1, v1] = events[i];

        maxOverallValue = Math.max(maxOverallValue, v1);

        const targetStartTimeForSecondEvent = e1 + 1;
        const idx = lowerBound(events, targetStartTimeForSecondEvent);

        if (idx < n) { 
            maxOverallValue = Math.max(maxOverallValue, v1 + suffixMaxValues[idx]);
        }
    }

    return maxOverallValue;
};