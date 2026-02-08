function secondsToRemoveOccurrences(s) {
    let maxTime = 0;
    let count = 0;

    while (s.includes('01')) {
        count++;
        s = s.replace(/01/g, '10');
        maxTime = Math.max(maxTime, count);
    }

    return maxTime;
}