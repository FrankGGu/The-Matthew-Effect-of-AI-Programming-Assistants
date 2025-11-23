var largestPalindrome = function(n) {
    if (n === 1) {
        return 9;
    }

    const upper = Math.pow(10, n) - 1;
    const lower = Math.pow(10, n - 1);

    for (let i = upper; i >= lower; i--) {
        const s = String(i);
        const p = BigInt(s + s.split('').reverse().join(''));

        for (let j = upper; BigInt(j) * BigInt(j) >= p; j--) {
            if (p % BigInt(j) === 0n) {
                const k = p / BigInt(j);
                if (k >= lower) {
                    return Number(p % 1337n);
                }
            }
        }
    }
    return -1;
};