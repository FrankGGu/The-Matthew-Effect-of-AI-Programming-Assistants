function maximumBinaryString(bin) {
    let countZero = 0;
    let result = '';

    for (let i = 0; i < bin.length; i++) {
        if (bin[i] === '0') {
            countZero++;
        } else {
            result += '1';
        }
    }

    if (countZero === 0) return result;

    return result + '1'.repeat(countZero - 1) + '0';
}