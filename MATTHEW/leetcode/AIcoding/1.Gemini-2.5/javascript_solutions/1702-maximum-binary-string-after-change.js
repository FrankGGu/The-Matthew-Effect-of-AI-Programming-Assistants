var maximumBinaryString = function(binary) {
    const n = binary.length;
    let countZeros = 0;
    let firstZeroIdx = -1;

    for (let i = 0; i < n; i++) {
        if (binary[i] === '0') {
            countZeros++;
            if (firstZeroIdx === -1) {
                firstZeroIdx = i;
            }
        }
    }

    if (countZeros === 0) {
        return binary;
    }

    const result = new Array(n).fill('1');
    const zeroPosition = firstZeroIdx + countZeros - 1;
    result[zeroPosition] = '0';

    return result.join('');
};