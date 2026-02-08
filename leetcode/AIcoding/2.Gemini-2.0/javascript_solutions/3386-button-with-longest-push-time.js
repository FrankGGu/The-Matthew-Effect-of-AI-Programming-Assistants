var slowestKey = function(releaseTimes, pressedKeys) {
    let maxDuration = releaseTimes[0];
    let slowestKey = pressedKeys[0];

    for (let i = 1; i < releaseTimes.length; i++) {
        let duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration) {
            maxDuration = duration;
            slowestKey = pressedKeys[i];
        } else if (duration === maxDuration && pressedKeys[i] > slowestKey) {
            slowestKey = pressedKeys[i];
        }
    }

    return slowestKey;
};