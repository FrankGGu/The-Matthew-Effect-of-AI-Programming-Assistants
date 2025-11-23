function longestBinarySubsequenceLessThanOrEqualToK(binary, k) {
    let count = 0;
    let num = 0;
    for (let i = binary.length - 1; i >= 0; i--) {
        if (binary[i] === '1') {
            num += Math.pow(2, count);
            if (num > k) break;
            count++;
        }
    }
    return count;
}