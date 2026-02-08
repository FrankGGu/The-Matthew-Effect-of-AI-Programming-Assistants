var checkZeroOnes = function(s) {
    let maxOnesLength = 0;
    let maxZerosLength = 0;
    let currentOnesLength = 0;
    let currentZerosLength = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            currentOnesLength++;
            currentZerosLength = 0;
        } else {
            currentZerosLength++;
            currentOnesLength = 0;
        }

        maxOnesLength = Math.max(maxOnesLength, currentOnesLength);
        maxZerosLength = Math.max(maxZerosLength, currentZerosLength);
    }

    return maxOnesLength > maxZerosLength;
};