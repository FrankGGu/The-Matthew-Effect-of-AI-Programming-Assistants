var maximumBinaryString = function(binary) {
    let zeros = 0;
    let onesBeforeFirstZero = 0;

    for (let i = 0; i < binary.length; i++) {
        if (binary[i] === '0') {
            zeros++;
        } else if (zeros === 0) {
            onesBeforeFirstZero++;
        }
    }

    if (zeros === 0) {
        return binary;
    }

    let result = '1'.repeat(binary.length - zeros) + '0' + '1'.repeat(zeros - 1);

    return result;
};