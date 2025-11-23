var slowestKey = function(releaseTimes, keysPressed) {
    let maxDuration = releaseTimes[0];
    let resultKey = keysPressed[0];

    for (let i = 1; i < releaseTimes.length; i++) {
        const currentDuration = releaseTimes[i] - releaseTimes[i - 1];
        const currentKey = keysPressed[i];

        if (currentDuration > maxDuration) {
            maxDuration = currentDuration;
            resultKey = currentKey;
        } else if (currentDuration === maxDuration) {
            if (currentKey > resultKey) {
                resultKey = currentKey;
            }
        }
    }

    return resultKey;
};