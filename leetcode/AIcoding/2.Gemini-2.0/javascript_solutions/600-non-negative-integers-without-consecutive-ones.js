var findIntegers = function(n) {
    let fib = [1, 2];
    for (let i = 2; i <= 30; i++) {
        fib[i] = fib[i - 1] + fib[i - 2];
    }

    let ans = 0;
    let prevBit = 0;
    for (let i = 30; i >= 0; i--) {
        let bit = (n >> i) & 1;
        if (bit === 1) {
            ans += fib[i];
            if (prevBit === 1) {
                return ans;
            }
            prevBit = 1;
        } else {
            prevBit = 0;
        }
    }

    return ans + 1;
};