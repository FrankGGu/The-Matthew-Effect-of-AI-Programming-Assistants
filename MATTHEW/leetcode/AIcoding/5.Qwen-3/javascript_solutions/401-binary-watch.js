function readBinaryWatch(num) {
    const result = [];

    for (let h = 0; h < 12; h++) {
        for (let m = 0; m < 60; m++) {
            if (countBits(h) + countBits(m) === num) {
                result.push(`${h}:${m < 10 ? '0' + m : m}`);
            }
        }
    }

    return result;
}

function countBits(n) {
    let count = 0;
    while (n > 0) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}