var findIntegers = function(n) {
    let fib = [1, 2];
    for (let i = 2; i < 32; i++) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }

    let prevBit = 0, count = 0;
    for (let i = 31; i >= 0; i--) {
        if (n & (1 << i)) {
            count += fib[i];
            if (prevBit) return count;
            prevBit = 1;
        } else {
            prevBit = 0;
        }
    }
    return count + 1;
};