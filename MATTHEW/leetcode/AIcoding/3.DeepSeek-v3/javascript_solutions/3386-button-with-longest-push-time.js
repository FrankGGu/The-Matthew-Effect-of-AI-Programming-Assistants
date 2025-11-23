var longestPressedTime = function(keysPressed, releaseTimes) {
    let maxTime = releaseTimes[0];
    let currentTime = releaseTimes[0];

    for (let i = 1; i < keysPressed.length; i++) {
        if (keysPressed[i] === keysPressed[i - 1]) {
            currentTime += releaseTimes[i] - releaseTimes[i - 1];
        } else {
            currentTime = releaseTimes[i] - releaseTimes[i - 1];
        }
        maxTime = Math.max(maxTime, currentTime);
    }

    return maxTime;
};