var binaryGap = function(n) {
    let maxGap = 0;
    let lastOnePos = -1;
    let currentPos = 0;

    while (n > 0) {
        if ((n & 1) === 1) { // If the current bit is 1
            if (lastOnePos !== -1) { // If we've seen a 1 before
                maxGap = Math.max(maxGap, currentPos - lastOnePos);
            }
            lastOnePos = currentPos; // Update the position of the last seen 1
        }
        n >>= 1; // Right shift n by 1 bit
        currentPos++; // Increment current bit position
    }

    return maxGap;
};