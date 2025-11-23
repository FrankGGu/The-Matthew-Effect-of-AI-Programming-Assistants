function maximumOddBinaryNumber(s) {
    let countOnes = 0;
    for (let char of s) {
        if (char === '1') countOnes++;
    }
    let length = s.length;
    return '1'.repeat(countOnes) + '0'.repeat(length - countOnes - 1) + '1';
}