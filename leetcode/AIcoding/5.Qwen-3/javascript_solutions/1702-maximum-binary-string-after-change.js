function maxBinaryString(binary) {
    let n = binary.length;
    let zeros = 0;
    let ones = 0;
    let firstZero = -1;

    for (let i = 0; i < n; i++) {
        if (binary[i] === '0') {
            zeros++;
            if (firstZero === -1) {
                firstZero = i;
            }
        } else {
            ones++;
        }
    }

    if (zeros === 0 || zeros === n) {
        return binary;
    }

    let result = new Array(n).fill('1');
    let pos = firstZero;
    for (let i = 0; i < zeros; i++) {
        result[pos++] = '0';
    }

    return result.join('');
}