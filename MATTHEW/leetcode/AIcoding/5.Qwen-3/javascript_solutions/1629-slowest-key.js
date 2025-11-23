function slowestKey(keyPresses, releaseTimes) {
    let maxDuration = releaseTimes[0];
    let resultChar = keyPresses[0];

    for (let i = 1; i < keyPresses.length; i++) {
        const duration = releaseTimes[i] - releaseTimes[i - 1];
        if (duration > maxDuration || (duration === maxDuration && keyPresses[i] > resultChar)) {
            maxDuration = duration;
            resultChar = keyPresses[i];
        }
    }

    return resultChar;
}