var findMinimumTime = function(entry, lastRoom) {
    let currentTime = 0;

    for (let i = 0; i <= lastRoom; i++) {
        currentTime = Math.max(currentTime, entry[i]);
        if (i < lastRoom) {
            currentTime += 1;
        }
    }

    return currentTime;
};