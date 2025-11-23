var largestAltitude = function(gain) {
    let maxAltitude = 0;
    let currentAltitude = 0;

    for (let i = 0; i < gain.length; i++) {
        currentAltitude += gain[i];
        if (currentAltitude > maxAltitude) {
            maxAltitude = currentAltitude;
        }
    }

    return maxAltitude;
};