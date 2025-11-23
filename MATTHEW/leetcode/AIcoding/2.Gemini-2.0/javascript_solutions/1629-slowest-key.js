var slowestKey = function(releaseTimes, keysPressed) {
    let maxDuration = releaseTimes[0];
    let slowestKey = keysPressed[0];

    for (let i = 1; i < releaseTimes.length; i++) {
        let duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration) {
            maxDuration = duration;
            slowestKey = keysPressed[i];
        } else if (duration === maxDuration && keysPressed[i] > slowestKey) {
            slowestKey = keysPressed[i];
        }
    }

    return slowestKey;
};