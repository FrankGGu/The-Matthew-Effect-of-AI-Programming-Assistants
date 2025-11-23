var slowestKey = function(releaseTimes, keysPressed) {
    let maxDuration = releaseTimes[0];
    let slowestKeyChar = keysPressed[0];
    let previousReleaseTime = releaseTimes[0];

    for (let i = 1; i < releaseTimes.length; i++) {
        const currentDuration = releaseTimes[i] - previousReleaseTime;
        const currentKeyChar = keysPressed[i];

        if (currentDuration > maxDuration) {
            maxDuration = currentDuration;
            slowestKeyChar = currentKeyChar;
        } else if (currentDuration === maxDuration) {
            if (currentKeyChar > slowestKeyChar) {
                slowestKeyChar = currentKeyChar;
            }
        }
        previousReleaseTime = releaseTimes[i];
    }

    return slowestKeyChar;
};