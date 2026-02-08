var minimumTimeToBreakLocks = function(locks, keyPresses) {
    let minTime = Infinity;
    for (let i = 0; i < (1 << locks.length); i++) {
        let currentTime = 0;
        let currentLocks = [];
        for (let j = 0; j < locks.length; j++) {
            if ((i >> j) & 1) {
                currentLocks.push(locks[j]);
            }
        }

        if (currentLocks.length === 0) continue;

        currentLocks.sort((a, b) => a - b);

        currentTime += currentLocks[0];
        for (let j = 1; j < currentLocks.length; j++) {
            currentTime += Math.min(currentLocks[j] - currentLocks[j - 1], keyPresses);
        }

        currentTime += keyPresses;
        minTime = Math.min(minTime, currentTime);
    }
    return minTime;
};