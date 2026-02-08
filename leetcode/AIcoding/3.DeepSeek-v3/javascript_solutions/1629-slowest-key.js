var slowestKey = function(releaseTimes, keysPressed) {
    let maxDuration = releaseTimes[0];
    let result = keysPressed[0];

    for (let i = 1; i < releaseTimes.length; i++) {
        const duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration) {
            maxDuration = duration;
            result = keysPressed[i];
        } else if (duration === maxDuration) {
            if (keysPressed[i] > result) {
                result = keysPressed[i];
            }
        }
    }

    return result;
};