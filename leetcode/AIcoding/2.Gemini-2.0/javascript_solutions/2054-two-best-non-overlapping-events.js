var maxTwoEvents = function(events) {
    events.sort((a, b) => a[1] - b[1]);
    let maxVal = 0;
    let suffixMax = new Array(events.length).fill(0);
    suffixMax[events.length - 1] = events[events.length - 1][2];
    for (let i = events.length - 2; i >= 0; i--) {
        suffixMax[i] = Math.max(suffixMax[i + 1], events[i][2]);
    }

    for (let i = 0; i < events.length; i++) {
        let eventVal = events[i][2];
        let endTime = events[i][1];
        let low = i + 1;
        let high = events.length - 1;
        let nextEventIndex = events.length;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (events[mid][0] > endTime) {
                nextEventIndex = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }

        let nextEventVal = 0;
        if (nextEventIndex < events.length) {
            nextEventVal = suffixMax[nextEventIndex];
        }

        maxVal = Math.max(maxVal, eventVal + nextEventVal);
    }

    return maxVal;
};