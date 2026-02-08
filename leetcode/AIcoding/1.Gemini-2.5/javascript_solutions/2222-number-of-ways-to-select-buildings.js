var numberOfWays = function(s) {
    let totalZeros = 0;
    let totalOnes = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            totalZeros++;
        } else {
            totalOnes++;
        }
    }

    let count = 0;
    let currentZeros = 0; // Number of '0's encountered so far (to the left of current index)
    let currentOnes = 0;  // Number of '1's encountered so far (to the left of current index)

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '0') {
            // If the current building is '0', it can be the middle building of a "101" sequence.
            // Number of '1's to its left: currentOnes
            // Number of '1's to its right: totalOnes - currentOnes
            count += currentOnes * (totalOnes - currentOnes);
            currentZeros++;
        } else { // s[i] === '1'
            // If the current building is '1', it can be the middle building of a "010" sequence.
            // Number of '0's to its left: currentZeros
            // Number of '0's to its right: totalZeros - currentZeros
            count += currentZeros * (totalZeros - currentZeros);
            currentOnes++;
        }
    }

    return count;
};