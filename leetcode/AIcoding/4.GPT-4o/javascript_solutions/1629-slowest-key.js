var slowestKey = function(releaseTimes, keysPressed) {
    let maxDuration = 0;
    let slowestKey = '';

    for (let i = 0; i < releaseTimes.length; i++) {
        let duration = releaseTimes[i] - (i === 0 ? 0 : releaseTimes[i - 1]);

        if (duration > maxDuration || (duration === maxDuration && keysPressed[i] > slowestKey)) {
            maxDuration = duration;
            slowestKey = keysPressed[i];
        }
    }

    return slowestKey;
};