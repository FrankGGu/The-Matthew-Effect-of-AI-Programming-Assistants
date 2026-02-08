var maximumOddBinaryNumber = function(s) {
    let onesCount = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === '1') {
            onesCount++;
        }
    }

    const zerosCount = s.length - onesCount;

    // The largest odd binary number must end with '1'.
    // To maximize the number, place remaining '1's at the beginning.
    // Then place all '0's.
    // Finally, place the last '1'.
    return '1'.repeat(onesCount - 1) + '0'.repeat(zerosCount) + '1';
};