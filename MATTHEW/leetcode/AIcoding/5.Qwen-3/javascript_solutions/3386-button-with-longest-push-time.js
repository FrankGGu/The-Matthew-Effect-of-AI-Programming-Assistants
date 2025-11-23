function longestPushTime(startTimes, endTimes) {
    let maxDuration = 0;
    for (let i = 0; i < startTimes.length; i++) {
        const duration = endTimes[i] - startTimes[i];
        if (duration > maxDuration) {
            maxDuration = duration;
        }
    }
    return maxDuration;
}