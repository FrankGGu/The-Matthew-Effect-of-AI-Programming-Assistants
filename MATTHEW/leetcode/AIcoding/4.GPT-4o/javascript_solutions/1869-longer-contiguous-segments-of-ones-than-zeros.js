var checkZeroOnes = function(s) {
    let maxOnes = 0, maxZeros = 0, currentOnes = 0, currentZeros = 0;

    for (let char of s) {
        if (char === '1') {
            currentOnes++;
            maxOnes = Math.max(maxOnes, currentOnes);
            currentZeros = 0;
        } else {
            currentZeros++;
            maxZeros = Math.max(maxZeros, currentZeros);
            currentOnes = 0;
        }
    }

    return maxOnes > maxZeros;
};