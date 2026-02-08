function maximumBinaryString(binary) {
    let countZero = 0;
    let n = binary.length;

    for (let char of binary) {
        if (char === '0') countZero++;
    }

    if (countZero === 0) return binary;

    let result = '1'.repeat(n - countZero - 1) + '0'.repeat(countZero + 1);

    return result;
}