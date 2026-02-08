var maximumOperations = function(s) {
    let ans = 0;
    let currentOnes = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            currentOnes++;
        } else { // s[i] === '0'
            if (currentOnes > 0) {
                ans += currentOnes;
                currentOnes = 0; // Reset currentOnes as these '1's are considered moved past this '0'
            }
        }
    }

    return ans;
};