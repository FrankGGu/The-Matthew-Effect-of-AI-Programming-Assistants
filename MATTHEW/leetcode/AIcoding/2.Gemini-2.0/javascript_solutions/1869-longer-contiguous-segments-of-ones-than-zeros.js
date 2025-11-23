var checkZeroOnes = function(s) {
    let onesCount = 0;
    let zerosCount = 0;
    let maxOnes = 0;
    let maxZeros = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            onesCount++;
            zerosCount = 0;
        } else {
            zerosCount++;
            onesCount = 0;
        }

        maxOnes = Math.max(maxOnes, onesCount);
        maxZeros = Math.max(maxZeros, zerosCount);
    }

    return maxOnes > maxZeros;
};