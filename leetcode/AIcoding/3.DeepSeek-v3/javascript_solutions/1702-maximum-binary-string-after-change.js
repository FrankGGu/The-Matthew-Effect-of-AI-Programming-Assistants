var maximumBinaryString = function(binary) {
    let zeros = 0;
    let firstZeroPos = -1;
    const n = binary.length;

    for (let i = 0; i < n; i++) {
        if (binary[i] === '0') {
            zeros++;
            if (firstZeroPos === -1) {
                firstZeroPos = i;
            }
        }
    }

    if (zeros <= 1) {
        return binary;
    }

    const res = new Array(n).fill('1');
    res[firstZeroPos + zeros - 1] = '0';
    return res.join('');
};