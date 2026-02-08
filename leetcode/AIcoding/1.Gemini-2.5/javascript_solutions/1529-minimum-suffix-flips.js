var minFlips = function(target) {
    let flips = 0;
    let currentExpectedBit = '0';

    for (let i = 0; i < target.length; i++) {
        if (target[i] !== currentExpectedBit) {
            flips++;
            // Toggle the expected bit for subsequent characters
            currentExpectedBit = currentExpectedBit === '0' ? '1' : '0';
        }
    }

    return flips;
};