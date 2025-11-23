function numSubstrings(s) {
    let count = 0;
    let consecutiveOnes = 0;

    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            consecutiveOnes++;
            count += consecutiveOnes;
        } else {
            consecutiveOnes = 0;
        }
    }

    return count;
}